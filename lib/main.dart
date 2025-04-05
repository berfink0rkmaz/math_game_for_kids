import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'home_page_multipication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math Game for Kids',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/multiplication': (context) => const HomePageMul(),
      },
    );
  }
}
