import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../theme/theme.dart';


enum SingingCharacter {lightMode, darkMode}

class ChooseTheme extends StatefulWidget {
  const ChooseTheme({Key? key}) : super(key: key);

  @override
  State<ChooseTheme> createState() => _ChooseThemeState();
}

class _ChooseThemeState extends State<ChooseTheme> {
  SingingCharacter? _character;

  @override
  void initState() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _character = themeProvider.getThemeData == lightMode
        ? SingingCharacter.lightMode
        : SingingCharacter.darkMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор темы'),
      ),
      body: Material(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0), // Отступ сверху
              child: ListTile(
                title: const Text('Светлая тема'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.lightMode,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      Provider.of<ThemeProvider>(context, listen: false).changeTheme();
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text('Тёмная тема'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.darkMode,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                    Provider.of<ThemeProvider>(context, listen: false).changeTheme();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
