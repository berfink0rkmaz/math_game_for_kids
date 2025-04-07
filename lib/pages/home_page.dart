import 'package:flutter/material.dart';
import 'home_page_addition.dart';
import 'home_page_multipication.dart';
import 'home_page_division.dart';
import 'home_page_substraction.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0), // pastel şeftali
      appBar: AppBar(
        title: const Text("Hangi Oyunu Oynamak İstiyorsunuz?"),
        centerTitle: true,
        backgroundColor: const Color(0xFFBBDEFB), // pastel buz mavisi
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Başlık
              const Text(
                '🧠 Oyunlar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32), // koyu yeşil
                ),
              ),
              const SizedBox(height: 30),

              // Toplama Oyunu
              _buildGameButton(
                context,
                label: 'Toplama Oyunu',
                icon: Icons.add,
                page: const HomePageAddition(),
              ),

              const SizedBox(height: 16),

              // Çarpma Oyunu
              _buildGameButton(
                context,
                label: 'Çarpma Oyunu',
                icon: Icons.clear,
                page: const HomePageMultiplication(),
              ),

              const SizedBox(height: 16),

              // Bölme Oyunu
              _buildGameButton(
                context,
                label: 'Bölme Oyunu',
                icon: Icons.percent,
                page: const HomePageDivision(),
              ),

              const SizedBox(height: 16),

              // Çıkarma Oyunu
              _buildGameButton(
                context,
                label: 'Çıkarma Oyunu',
                icon: Icons.remove,
                page: const HomePageSubstraction(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tek bir oyun butonunu oluşturan yardımcı metod
  Widget _buildGameButton(BuildContext context,
      {required String label, required IconData icon, required Widget page}) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      icon: Icon(icon, color: Colors.black87),
      label: Text(label, style: const TextStyle(color: Colors.black87)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC8E6C9), // pastel nane
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}