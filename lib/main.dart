import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lista_tarefas/page/controllers/controllers.dart';

import 'package:lista_tarefas/provider/theme_provider.dart';
import 'package:lista_tarefas/splash/splash_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return GetMaterialApp(
            themeMode: themeProvider.themeMode,
            theme: Mythemes.lightTheme,
            darkTheme: Mythemes.darkTheme,
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}
