import 'package:flutter/material.dart';
import 'package:travel_application/screens/profile/changeThemeScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: const Text('Внешний вид'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChooseTheme()),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}