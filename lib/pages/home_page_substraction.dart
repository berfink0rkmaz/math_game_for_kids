import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_game_for_kids/util/my_button.dart';
import 'package:math_game_for_kids/util/result_message.dart';
import '../custom_drawer.dart';
import '../preferences_service.dart';

class HomePageSub extends StatefulWidget {
  const HomePageSub({super.key});

  @override
  State<HomePageSub> createState() => _HomePageSubtractionState();
}

class _HomePageSubtractionState extends State<HomePageSub> {
  List<String> numberPad = [
    '1', '2', '3', 'C',
    '4', '5', '6', 'Del',
    '7', '8', '9', '=',
    ' ', '0', ' ',
  ];

  int numberA = 1;
  int numberB = 1;
  String userAnswer = '';

  int correctCount = 0;
  int wrongCount = 0;

  final PreferencesService _preferencesService = PreferencesService();

  var randomNumber = Random();

  @override
  void initState() {
    super.initState();
    _preferencesService.loadScore().then((scores) {
      setState(() {
        correctCount = scores['correct']!;
        wrongCount = scores['wrong']!;
      });
    });
    generateNewQuestion();
  }

  void generateNewQuestion() {
    numberA = randomNumber.nextInt(99) + 1;
    numberB = randomNumber.nextInt(numberA) + 1; // negatif sonuç olmasın
  }

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'Del') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length <= 3) {
        userAnswer += button;
      }
    });
  }

  void checkResult() {
    if (numberA - numberB == int.tryParse(userAnswer)) {
      correctCount++;
      _preferencesService.saveScore(correctCount, wrongCount);
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Tebrikler!',
            onTap: goToNextQuestion,
            icon: Icons.check_circle_outline,
          );
        },
      );
    } else {
      wrongCount++;
      _preferencesService.saveScore(correctCount, wrongCount);
      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Tekrar Dene!',
            onTap: goToBackQuestion,
            icon: Icons.refresh,
          );
        },
      );
    }
  }

  void goToNextQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
      generateNewQuestion();
    });
  }

  void goToBackQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doğru: $correctCount | Yanlış: $wrongCount"),
        backgroundColor: Color(0xFFBBDEFB),
        foregroundColor: Colors.black87,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFFFFF3E0), // pastel şeftali
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFC8E6C9), // pastel nane yeşili
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '$numberA − $numberB = $userAnswer',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32), // koyu yeşil
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: numberPad.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return MyButton(
                    child: numberPad[index],
                    onTap: () => buttonTapped(numberPad[index]),
                    backgroundColor: const Color(0xFFFFECB3), // pastel vanilya sarı
                    textColor: Colors.black87,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}