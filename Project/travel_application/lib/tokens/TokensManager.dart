import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {

  Future<bool> hasTokens() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString("accessToken");
    final refreshToken = sharedPreferences.getString("refreshToken");
    return accessToken != null && refreshToken != null;
  }

  Future<String?> getAccessToken() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    final accessToken = sharedPreferences.getString("accessToken");
    return accessToken;
  }

  Future<String?> getRefreshToken() async{
    final sharedPreferences = await SharedPreferences.getInstance();
    final refreshToken = sharedPreferences.getString("refreshToken");
    return refreshToken;
  }

  Future<void> saveAccessToken(String accessToken) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accessToken", accessToken);
  }
}
