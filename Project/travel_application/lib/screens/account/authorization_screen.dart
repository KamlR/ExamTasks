import 'package:flutter/material.dart';
import 'package:travel_application/screens/bottom_navigation_screen.dart';
import 'package:travel_application/server/trips_server.dart';
import 'dart:convert';
import '../../messageDilogs/errorDialod.dart';
import '../../models/user.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authorization'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Поле ввода для логина
              TextField(
                controller: _loginController,
                decoration: const InputDecoration(labelText: 'Логин'),
              ),
              const SizedBox(height: 20),
              // Поле ввода для пароля
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Пароль'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Кнопка "Зарегистрироваться"
              ElevatedButton(
                onPressed: () {
                  checkUserdata();
                },
                child: const Text('Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkUserdata() async {
    String message = "";
    if(_loginController.text == ""){
      message+="Вы не ввели логин\n";
    }
    if(_passwordController.text == ""){
      message+="Вы не ввели пароль\n";
    }

    if (message.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(message: message);
        },
      );

    }
    else{
      User user = User(firstName: "", lastName: "", age: 0, description: "", 
      login: _loginController.text, password: _passwordController.text);
      String userJson = json.encode(user.toJson());
      int answer = await ServerTrips().sendAuthorizationRequest(userJson);
      if(answer == 1){
          // ignore: use_build_context_synchronously
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(message: "Такого логина нет в системе!");
            },
        );
      }
      else if(answer == 2){
        // ignore: use_build_context_synchronously
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(message: "Вы ввели неверный пароль!");
            },
        );
      }
      else{
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigationScreen()),
          );
      }
    }
}

}
