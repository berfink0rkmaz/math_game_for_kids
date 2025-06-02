import 'package:flutter/material.dart';
import '../custom_drawer.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget body;

  const BasePage({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFBBDEFB),
        foregroundColor: Colors.black87,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFFFFF3E0),
      body: body,
    );
  }
}
