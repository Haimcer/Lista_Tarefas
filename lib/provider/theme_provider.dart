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
      colorScheme: ColorScheme.dark(),
      iconTheme: IconThemeData(color: Colors.purple.shade200),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple.shade200,
          titleTextStyle: TextStyle(color: Colors.white)),
      toggleButtonsTheme: ToggleButtonsThemeData(color: Colors.purple));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.white,
      colorScheme: ColorScheme.light(),
      iconTheme: IconThemeData(color: Colors.purple),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          titleTextStyle: TextStyle(color: Colors.white)),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color?>(
          Colors.purple,
        ),
        textStyle: MaterialStatePropertyAll<TextStyle?>(
            TextStyle(color: Colors.white)),
      )));
}
