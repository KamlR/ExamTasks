import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    background: Colors.white,
  ),
  textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.w500, 
            fontSize: 18
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500, 
            fontSize: 16
          ),
          bodyMedium: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.w500, 
            fontSize: 16
          ),
          bodySmall: TextStyle(
            color: Colors.black, 
            fontSize: 15
          ),
          labelMedium: TextStyle(
            color: Colors.black, 
            fontSize: 14
          ),
          //Для ссылок
          labelSmall: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            decoration: TextDecoration.underline
          ),
          
          
  )      
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
  ),
  textTheme: const TextTheme(
         titleLarge: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w500, 
            fontSize: 18
          ),
          titleSmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500, 
            fontSize: 16
          ),
          bodyMedium: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
          bodySmall: TextStyle(
            color: Colors.white, 
            fontSize: 15
          ),
          labelMedium: TextStyle(
            color: Colors.white, 
            fontSize: 14
          ),
          labelSmall: TextStyle(
            fontSize: 16,
            color: Colors.blue,
            decoration: TextDecoration.underline
          ),
  )      
);