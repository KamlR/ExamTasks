import 'package:flutter/material.dart';
import 'package:travel_application/screens/account/greeting_screen.dart';
import 'package:travel_application/screens/bottom_navigation_screen.dart';

import 'providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'tokens/TokensManager.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), 
      child: const TravelApp(),
    )
  );
}

class TravelApp extends StatelessWidget {
  const TravelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travelling App',
      theme: Provider.of<ThemeProvider>(context).getThemeData,
      routes: {
        '/': (context) => FutureBuilder<bool>(
              future: TokenManager().hasTokens(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasData && snapshot.data!) {
                    return const BottomNavigationScreen();
                  } else {
                    return const GreetingScreen();
                  }
                }
              },
            ),
      },
    );
  }
}