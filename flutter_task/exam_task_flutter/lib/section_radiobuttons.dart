import 'package:flutter/material.dart';

class SectionWithRadioButtons extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String?) onSelect;

  const SectionWithRadioButtons({super.key, 
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
        Column(
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: selectedOption,
              onChanged: onSelect,
            );
          }).toList(),
        ),
      ],
    );
  }
}