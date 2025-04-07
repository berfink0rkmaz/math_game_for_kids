import 'package:flutter/material.dart';
import '../const.dart';

class ResultMessage extends StatelessWidget {
  // Gösterilecek mesaj, tıklanınca çalışacak fonksiyon ve ikon
  final String message;
  final VoidCallback onTap;
  final icon;

  const ResultMessage({
    super.key,
    required this.message,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green, // Dialog arka plan rengi

      content: Container(
        height: 200,
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Öğeleri dikeyde eşit aralıkla yerleştir

          children: [
            // Sonucu gösteren metin
            Text(message, style: WhiteTextStyle),

            // Sonraki soruya geç butonu (ikon şeklinde)
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}