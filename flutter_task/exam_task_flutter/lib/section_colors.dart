import 'package:flutter/material.dart';

class SectionWithColors extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String?) onSelect;

  const SectionWithColors({super.key, 
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: options.map((option) {
            Color? color;
            if (title == 'Основной цвет') {
              if (option == 'Розовый') {
                color = Colors.pink;
              } else if (option == 'Желтый') {
                color = Colors.yellow;
              } else if (option == 'Зеленый') {
                color = Colors.green;
              }
            }

            return GestureDetector(
              onTap: () => onSelect(option),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: title == 'Основной цвет' && selectedOption == option ? color : selectedOption == option ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  option,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}