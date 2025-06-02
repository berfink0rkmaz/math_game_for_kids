import 'package:flutter/material.dart';
import 'package:math_game_for_kids/pages/home_page.dart';
import 'package:math_game_for_kids/pages/home_page_addition.dart';
import 'package:math_game_for_kids/pages/home_page_division.dart';
import 'package:math_game_for_kids/pages/home_page_substraction.dart';
import 'package:math_game_for_kids/pages/login_page.dart';
import 'package:math_game_for_kids/pages/profile_page.dart';
import 'pages/home_page_multipication.dart';

void main() {
  runApp(MyApp()); // Uygulama başlatılır
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Game', // Uygulama başlığı
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green, // Varsayılan tema rengi
      ),
      initialRoute: '/login', // Uygulamanın ilk açılacağı sayfa

      // Sayfa yönlendirmeleri (named routes)
      routes: {
        '/login': (context) => const LoginPage(),                       // Giriş ekranı
        '/home': (context) => const HomePage(),                         // Ana sayfa (oyun seçimi)
        '/multiplication': (context) => const HomePageMultiplication(), // Çarpma oyunu
        '/subtraction': (context) => const HomePageSubstraction(),      // Çıkarma oyunu
        '/division': (context) => const HomePageDivision(),             // Bölme oyunu
        '/addition': (context) => const HomePageAddition(),             // Toplama oyunu
        '/profile': (context) => const ProfilePage(),                   // Profil sayfası
      },
    );
  }
}
