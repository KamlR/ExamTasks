import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData currentThemeData = lightMode;
  ThemeData get getThemeData => currentThemeData;
  ThemeProvider(){
    getThemeFromSharedPreferences();
  }
  set setThemeData (ThemeData themeData){
    currentThemeData = themeData;
    notifyListeners();
  }

  void changeTheme(){
    if(currentThemeData == lightMode){
      setThemeData = darkMode;
      putThemeInSharedPreferences("dark");
    }
    else{
      setThemeData = lightMode; 
      putThemeInSharedPreferences("light");
    }
  }
  
  Future<void> getThemeFromSharedPreferences() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.containsKey("theme")){
      String? theme= sharedPreferences.getString("theme");
      if (theme == "light"){
        setThemeData = lightMode;
        notifyListeners();
      }
      else if(theme == "dark"){
        setThemeData = darkMode; 
        notifyListeners();
      }
    }
    else{
      putThemeInSharedPreferences("light");
    }
  }

  Future<void> putThemeInSharedPreferences(String theme) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("theme", theme);
  }

}