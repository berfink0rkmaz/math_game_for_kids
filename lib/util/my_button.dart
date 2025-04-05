import 'package:flutter/material.dart';
import '../const.dart';

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  var buttunColor = Colors.lightGreen[400];

  MyButton({
    super.key,
    required this.child,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    if(child == 'C'){
      buttunColor = Colors.green;
    }else if(child == 'Del'){
      buttunColor = Colors.red;
    }else if(child == '='){
      buttunColor = Colors.deepPurple;
    }else if(child == ' '){
      buttunColor = Colors.transparent;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttunColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              child,
              style: WhiteTextStyle,
            ),
          ),

        ),
      ),
    );
  }
}