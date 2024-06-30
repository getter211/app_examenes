// ignore_for_file: use_key_in_widget_constructors

import 'package:app_examenes/pages/view_game.dart';
import 'package:app_examenes/pages/view_result.dart';
import 'package:app_examenes/pages/view_rules.dart';
import 'package:flutter/material.dart';
import 'package:app_examenes/pages/view_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app_examenes',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light().copyWith(
          surface: Colors.white,
          primary: Colors.blue,
          secondary: Colors.red,
        ),
      ),
      initialRoute: 'view_home',
      routes: {
        'view_home': (context) => const Home(),
        'view_Rules': (context) => const Rules(),
        'view_Game': (context) => const Game([]),
        'view_Result': (context) => const Result([], [], []),
      },
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              constraints: const BoxConstraints(
                minWidth: 1000,
                minHeight: 700,
              ),
              child: child,
            );
          },
        );
      },
    );
  }
}
