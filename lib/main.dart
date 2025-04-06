import 'package:flutter/material.dart';
import 'package:math_game_for_kids/pages/home_page.dart';
import 'package:math_game_for_kids/pages/home_page_division.dart';
import 'package:math_game_for_kids/pages/home_page_substraction.dart';
import 'package:math_game_for_kids/pages/login_page.dart';

import 'pages/home_page_multipication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Game',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/multiplication': (context) => const HomePageMul(),
        '/subtraction': (context) => const HomePageSub(),
        '/division': (context) => const HomePageDiv(),
      },
    );
  }
}
