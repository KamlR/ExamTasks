import 'package:flutter/material.dart';

class CriteriaScreen extends StatelessWidget {
  const CriteriaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criteria'),
      ),
      body: const Center(
        child: Text(
          'Тут должны быть критерии',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
