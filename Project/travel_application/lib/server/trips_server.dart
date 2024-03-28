import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_application/tokens/TokensManager.dart';

import '../models/trip.dart';

class ServerTrips{
  Future<List<Trip>> getAllTripsFromServer(int num) async{
    String url;
    if(num == 1){
      url = "http://10.0.2.2:3001/api/trips/getall";
    }
    else if(num == 2){
      url = "http://10.0.2.2:3001/api/trips/go_trips";
    }
    else{
      url = "http://10.0.2.2:3001/api/trips/created_trips";
    }
    Dio dio = Dio(); 
    String? accessToken = await TokenManager().getAccessToken();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.validateStatus = (status) => true;
    var response = await dio.get(url);
    // Access токен просрочен
    if(response.statusCode == 401){
        accessToken = await getAccesstokenByRefresh();

        dio.options.headers['Authorization'] = 'Bearer $accessToken';
        response = await dio.get(url);
      }
    final List<dynamic> jsonResponse = response.data;
    List<Trip> tripsList = jsonResponse.map((json) => Trip.fromJson(json)).toList();
    return tripsList;
  }
  Future<void> sendCreatingTripRequest(String newTripInfo) async{
    String url = "http://10.0.2.2:3001/api/trips/create";
    String? accessToken = await TokenManager().getAccessToken();
    final response = await Dio().post(
      url,
      data: newTripInfo,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
        validateStatus: (status) {
          return true;
        },
      ),
    );
  }
  Future<bool> getSubscribeInfo(int tripId) async{
    String url = "http://10.0.2.2:3001/api/trips/check_participation/$tripId";
    Dio dio = Dio(); 
    String? accessToken = await TokenManager().getAccessToken();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.validateStatus = (status) => true;
    var response = await dio.get(url);
    // Access токен просрочен
    if(response.statusCode == 401){
        accessToken = await getAccesstokenByRefresh();
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
        response = await dio.get(url);
      }
    return response.data['subscribed'];
  }

  Future<void> sendRegistrTripInfo(int tripId) async{
    String url = "http://10.0.2.2:3001/api/trips/registr_on_trip/$tripId";
    Dio dio = Dio(); 
    String? accessToken = await TokenManager().getAccessToken();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.validateStatus = (status) => true;
    var response = await dio.post(url);
    if(response.statusCode == 401){
        accessToken = await getAccesstokenByRefresh();
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
        response = await dio.post(url);
      }
  }
  Future<void> sendUnRegistrTripInfo(int tripId) async{
    String url = "http://10.0.2.2:3001/api/trips/unregistr_from_trip/$tripId";
    Dio dio = Dio(); 
    String? accessToken = await TokenManager().getAccessToken();
    dio.options.headers['Authorization'] = 'Bearer $accessToken';
    dio.options.validateStatus = (status) => true;
    var response = await dio.delete(url);
    if(response.statusCode == 401){
        accessToken = await getAccesstokenByRefresh();
        dio.options.headers['Authorization'] = 'Bearer $accessToken';
        response = await dio.delete(url);
      }
  }
  Future<String> getAccesstokenByRefresh() async {
    String urlRefresh = "http://10.0.2.2:3001/api/user/get_access_by_refresh";
    String? refreshToken = await TokenManager().getRefreshToken();
    var response = await Dio().post(urlRefresh, data: {"refreshToken": refreshToken});
    if(response.statusCode == 200){
        String accessToken = response.data['accessToken'];
        await TokenManager().saveAccessToken(accessToken);
        return accessToken;
      }
      return "";
  }
  Future<bool> sendRegistrationRequest(String userInfo) async{
    String url = "http://10.0.2.2:3001/api/user/registration";
    final response = await Dio().post(
      url,
      data: userInfo,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        validateStatus: (status) {
          return true;
        },
      ),
    );
    if(response.statusCode == 200){
      final accessToken = response.data['accessToken'] as String;
      final refreshToken = response.data['refreshToken'] as String;
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('accessToken', accessToken);
      await sharedPreferences.setString('refreshToken', refreshToken);
      return true;
    }
    else if(response.statusCode == 400){
      return false;
    }
    return false;
  }

  Future<int> sendAuthorizationRequest(String userInfo) async{
    String url = "http://10.0.2.2:3001/api/user/authorization";
    final response = await Dio().post(
      url,
      data: userInfo,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        validateStatus: (status) {
          return true;
        },
      ),
    );
    if(response.statusCode == 200){
      final accessToken = response.data['accessToken'] as String;
      final refreshToken = response.data['refreshToken'] as String;
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('accessToken', accessToken);
      await sharedPreferences.setString('refreshToken', refreshToken);
      return 0;
    }
    // Неверный логин
    else if(response.statusCode == 400){
      return 1;
    }
    // Неверный пароль
    else if(response.statusCode == 401){
      return 2;
    }
    return 3;
  }
}