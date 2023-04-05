import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Mythemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.purple.shade200),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple.shade200,
          titleTextStyle: const TextStyle(color: Colors.white)),
      toggleButtonsTheme: const ToggleButtonsThemeData(color: Colors.purple));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.purple),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          titleTextStyle: TextStyle(color: Colors.white)),
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color?>(
          Colors.purple,
        ),
        textStyle: MaterialStatePropertyAll<TextStyle?>(
            TextStyle(color: Colors.white)),
      )));
}
