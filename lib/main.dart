import 'package:flutter/material.dart';
import 'package:lista_tarefas/page/home_page.dart';
import 'package:lista_tarefas/provider/theme_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

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
          return MaterialApp(
            title: 'Lista de tarefas',
            themeMode: themeProvider.themeMode,
            theme: Mythemes.lightTheme,
            darkTheme: Mythemes.darkTheme,
            home: const homePage(title: 'Lista de tarefas'),
            debugShowCheckedModeBanner: false,
          );
        },
      );
}
