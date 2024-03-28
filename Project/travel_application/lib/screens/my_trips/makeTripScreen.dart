import 'package:flutter/material.dart';
import 'package:travel_application/server/trips_server.dart';
import 'dart:convert';
import '../../messageDilogs/errorDialod.dart';
import '../../models/trip.dart';

class MakeTripScreen extends StatefulWidget {
  const MakeTripScreen({Key? key}) : super(key: key);

  @override
  State<MakeTripScreen> createState() => _MakeTripScreenState();
}

class _MakeTripScreenState extends State<MakeTripScreen> {
  // Создание контроллеров для полей ввода
  final TextEditingController titleController = TextEditingController();
  final TextEditingController destinatonController = TextEditingController();
  final TextEditingController numberOfDaysController = TextEditingController();
  final TextEditingController numberOfPeoplenController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your own trip'),
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
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 20),
              // Поле ввода для фамилии
              TextField(
                controller: destinatonController,
                decoration: const InputDecoration(labelText: 'Destination'),
              ),
              const SizedBox(height: 20),
              // Поле ввода для возраста
              TextField(
                controller: numberOfDaysController,
                decoration: const InputDecoration(labelText: 'Number of days'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              // Поле ввода для краткого описания
              TextField(
                controller: numberOfPeoplenController,
                decoration: const InputDecoration(labelText: 'Number of people'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              // Поле ввода для логина
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Url to image'),
              ),
              const SizedBox(height: 20),
              // Поле ввода для пароля
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 20),
              // Кнопка "Зарегистрироваться"
              ElevatedButton(
                onPressed: () {
                  checkTripData();
                },
                child: const Text('Создать поездку'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkTripData() async {
    String message = "";
    if(titleController.text == ""){
      message+="Вы не ввели название поездки\n";
    }
    if(destinatonController.text == ""){
      message+="Вы не указали, куда хотите поехать\n";
    }
    if(numberOfDaysController.text == ""){
      message+="Вы не указали длительность поездки\n";
    }
    if(numberOfPeoplenController.text == ""){
      message+="Вы не указали, сколько хотите взять людей с собой\n";
    }
    if(imageUrlController.text == ""){
      message+="Вы не прикрепили ссылку на картинку\n";
    }
    if(descriptionController.text == ""){
      message+="Вы не указали описание поездки\n";
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
      Trip newTrip = Trip(id: -1, title: titleController.text, 
      destination: destinatonController.text, numberOfDays: int.parse(numberOfDaysController.text), 
      numberOfPeople:int.parse(numberOfPeoplenController.text), imageUrl: imageUrlController.text,
      description: descriptionController.text, creator: "");
      String newTripJson = json.encode(newTrip.toJson());
      await ServerTrips().sendCreatingTripRequest(newTripJson);
    }
}

}
