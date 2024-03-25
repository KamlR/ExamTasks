import 'dart:math';

import 'package:flutter/material.dart';

import 'criteria.dart';
import 'section_colors.dart';
import 'section_radiobuttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedColor = '';
  String selectedFeedback = '';
  String selectedTransition = '';

  void setColor(String? color) {
    setState(() {
      selectedColor = color!;
    });
  }

  void setFeedback(String? feedback) {
    setState(() {
      selectedFeedback = feedback!;
    });
  }

  void setTransition(String? transition) {
    setState(() {
      selectedTransition = transition!;
    });
  }

  void submitOptions() {
    final random = Random();
    setColor(['Розовый', 'Желтый', 'Зеленый'][random.nextInt(3)]);
    setFeedback(['Dialog', 'SnackBar'][random.nextInt(2)]);
    setTransition(['Снизу Вверх', 'Сверху Вниз', 'Справо Налево'][random.nextInt(3)]);
  }

  void openFeedback() {
    if (selectedFeedback == 'Dialog') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Dialog'),
            content: const Text('Это диалоговое окно!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Закрыть'),
              ),
            ],
          );
        },
      );
    } else if (selectedFeedback == 'SnackBar') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Это SnackBar!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: [
          IconButton(
            onPressed: openFeedback,
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: ListView(
        children: [
          SectionWithColors(
            title: 'Основной цвет',
            options: const ['Розовый', 'Желтый', 'Зеленый'],
            selectedOption: selectedColor,
            onSelect: setColor,
          ),
          SectionWithRadioButtons(
            title: 'Показ результата',
            options: const ['Dialog', 'SnackBar'],
            selectedOption: selectedFeedback,
            onSelect: setFeedback,
          ),
          SectionWithRadioButtons(
            title: 'Переход между экранами',
            options: const ['Снизу Вверх', 'Сверху Вниз', 'Справо Налево'],
            selectedOption: selectedTransition,
            onSelect: setTransition,
          ),
          ElevatedButton(
            onPressed: submitOptions,
            child: const Text('Подобрать вариант'),
          ),
          ElevatedButton(
            onPressed: openFeedback,
            child: const Text('Открыть Dialog/SnackBar'),
          ),
          ElevatedButton(
            onPressed: tapCriteriaButton,
            child: const Text('Открыть критерии'),
          ),
        ],
      ),
    );
  }

  void tapCriteriaButton(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CriteriaScreen()
  ),
);}
}




