import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;

  const MyButton({
    super.key,
    required this.child,
    required this.onTap,
    this.backgroundColor = const Color(0xFFB2DFDB), // varsayılan pastel mint
    this.textColor = Colors.white, // varsayılan beyaz
  });

  @override
  Widget build(BuildContext context) {
    Color resolvedColor = backgroundColor;

    // Özel buton renkleri (isteğe göre koruyabiliriz)
    if (child == 'C') {
      resolvedColor = Colors.green;
    } else if (child == 'Del') {
      resolvedColor = Colors.red;
    } else if (child == '=') {
      resolvedColor = Colors.deepPurple;
    } else if (child == ' ') {
      resolvedColor = Colors.transparent;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: resolvedColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              child,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}