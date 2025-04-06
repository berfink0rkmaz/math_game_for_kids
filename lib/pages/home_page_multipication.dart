import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_game_for_kids/util/my_button.dart';
import 'package:math_game_for_kids/util/result_message.dart';
import '../preferences_service.dart';
import '../const.dart';
import '../custom_drawer.dart';

class HomePageMul extends StatefulWidget {
  const HomePageMul({super.key});

  @override
  State<HomePageMul> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageMul> {
  //number pad list
  List<String> numberPad = [
    '1', '2', '3', 'C',
    '4', '5', '6', 'Del',
    '7', '8', '9', '=',
    ' ', '0', ' ',
  ];

  final PreferencesService _preferencesService = PreferencesService();

  int numberA = 1;
  int numberB = 1;
  String userAnswer = '';

  int correctCount = 0;
  int wrongCount = 0;

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

    numberA = randomNumber.nextInt(99) + 1;
    numberB = randomNumber.nextInt(99) + 1;
  }

  //User tapped the button
  void buttonTapped(String button) {
    // print('Tıklanan buton: $button'); // Hangi buton tıklandığını görmek için
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

  //checking the correction
  void checkResult() {
    if (numberA * numberB == int.parse(userAnswer)) {
      setState(() {
        correctCount++;
      });
      _preferencesService.saveScore(correctCount, wrongCount);      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Correct!',
            onTap: goToNextQuestion,
            icon: Icons.arrow_forward,
          );
        },
      );
    } else {
      setState(() {
        wrongCount++;
      });
      _preferencesService.saveScore(correctCount, wrongCount);      showDialog(
        context: context,
        builder: (context) {
          return ResultMessage(
            message: 'Sorry try again!',
            onTap: goToBackQuestion,
            icon: Icons.rotate_left,
          );
        },
      );
    }
  }

  void goToNextQuestion() {
    Navigator.of(context).pop();

    //reset values
    setState(() {
      userAnswer = '';
    });
    //create a new guestion
    numberA = randomNumber.nextInt(9) + 1;
    numberB = randomNumber.nextInt(9) + 1;
  }

  void goToBackQuestion(){
    Navigator.of(context).pop();

    setState(() {
      userAnswer = '';
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Correct: $correctCount | Wrong: $wrongCount"),
        backgroundColor: Colors.green,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: Colors.green.shade300,
      body: Column(
        children: [
          //level progress
          Container(height: 140, color: Colors.green),
          // question part
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      numberA.toString() + ' x ' + numberB.toString() + ' = ',
                      style: WhiteTextStyle,
                    ),
                    //answer box
                    Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[400],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(userAnswer, style: WhiteTextStyle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //numbers part
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: numberPad.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),

                itemBuilder: (context, index) {
                  return MyButton(
                    child: numberPad[index],
                    onTap: () => buttonTapped(numberPad[index]),
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
