import 'package:flutter/material.dart';
import 'package:travel_application/server/trips_server.dart';
import 'dart:convert';
import '../../messageDilogs/errorDialod.dart';
import '../../models/user.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Создание контроллеров для полей ввода
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Поле ввода для имени
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              const SizedBox(height: 20),
              // Поле ввода для фамилии
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              const SizedBox(height: 20),
              // Поле ввода для возраста
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // Поле ввода для краткого описания
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              // Поле ввода для логина
              TextField(
                controller: _loginController,
                decoration: const InputDecoration(labelText: 'Login'),
              ),
              const SizedBox(height: 20),
              // Поле ввода для пароля
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Кнопка "Зарегистрироваться"
              ElevatedButton(
                onPressed: () {
                  checkUserdata();
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkUserdata() async {
    String message = "";
    if(_firstNameController.text == ""){
      message+="Вы не ввели имя\n";
    }
    if(_lastNameController.text == ""){
      message+="Вы не ввели фамилию\n";
    }
    if(_ageController.text == ""){
      message+="Вы не ввели возраст\n";
    }
    if(_descriptionController.text == ""){
      message+="Вы не ввели своё описание\n";
    }
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
      User user = User(firstName: _firstNameController.text, lastName: _lastNameController.text, 
      age: int.parse(_ageController.text), description: _descriptionController.text, 
      login: _loginController.text, password: _passwordController.text);
      String userJson = json.encode(user.toJson());
      bool answer = await ServerTrips().sendRegistrationRequest(userJson);
      if(!answer){
          // ignore: use_build_context_synchronously
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ErrorDialog(message: "Такой логин уже есть");
            },
        );
      }
      else{
        
      }
    }
}

}
