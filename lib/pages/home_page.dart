/*import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math/const.dart';
import 'package:math/util/my_button.dart';
import 'package:math/util/result_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //number pad list
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'Del',
    '1',
    '2',
    '3',
    '=',
    ' ',
    '0',
    ' ',
  ];

  //number A, number B
  int numberA = 1;
  int numberB = 1;

  // String answer
  String userAnswer = '';

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
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
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
      showDialog(
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

  //create rondom numbers
  var randomNumber = Random();

  @override
  void initState() {
    super.initState();
    numberA = randomNumber.nextInt(99) + 1;
    numberB = randomNumber.nextInt(99) + 1;
  }

  void goToNextQuestion() {
    Navigator.of(context).pop();

    //reset values
    setState(() {
      userAnswer = '';
    });
    //create a new guestion
    numberA = randomNumber.nextInt(99) + 1;
    numberB = randomNumber.nextInt(99) + 1;
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
                      numberA.toString() + ' + ' + numberB.toString() + ' = ',
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
                //physics: const NeverScrollableScrollPhysics(),
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
}*/
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
      appBar: AppBar(title: Text("Hangi Oyunu Oynamak İstiyorsunuz?")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Dikeyde ortalar
          crossAxisAlignment: CrossAxisAlignment.center, // Yatayda ortalar
          children: [
            // Oyunlar başlığı
            Text(
              'Oyunlar',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
              //textAlign: TextAlign.center, // Yatayda da ortalar
            ),
            SizedBox(height: 30), // Başlık ile butonlar arasındaki boşluk
            // Toplama Oyunu Butonu
            ElevatedButton(
              onPressed: () {
                // Toplama oyununa git
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageAdd()),
                );
              },
              child: Text('Toplama Oyunu'),
            ),
            SizedBox(height: 20), // Butonlar arasındaki boşluk
            // Çarpma Oyunu Butonu
            ElevatedButton(
              onPressed: () {
                // Çarpma oyununa git
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageMul()),
                );
              },
              child: Text('Çarpma Oyunu'),
            ),
            SizedBox(height: 20), // Butonlar arasındaki boşluk
            // Bölme Oyunu Butonu
            ElevatedButton(
              onPressed: () {
                // Bölme oyununa git
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageDiv()),
                );
              },
              child: Text('Bölme Oyunu'),
            ),
            SizedBox(height: 20), // Butonlar arasındaki boşluk
            // Çıkarma Oyunu Butonu
            ElevatedButton(
              onPressed: () {
                // Çıkarma oyununa git
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePageSub()),
                );
              },
              child: Text('Çıkarma Oyunu'),
            ),
          ],
        ),
      ),
    );
  }
}



/*import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_game_for_kids/util/my_button.dart';
import 'package:math_game_for_kids/util/result_message.dart';
import '../const.dart';
import '../custom_drawer.dart';
import '../preferences_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  late String currentUser;
  final PreferencesService _preferencesService = PreferencesService();
  final Random randomNumber = Random();

  @override
  void initState() {
    super.initState();
    loadUserAndScores();
    numberA = randomNumber.nextInt(99) + 1;
    numberB = randomNumber.nextInt(99) + 1;
  }

  void loadUserAndScores() async {
    final credentials = await _preferencesService.loadCredentials();
    final username = credentials['username'] ?? 'default';

    final scores = await _preferencesService.loadScoreForUser(username);

    setState(() {
      currentUser = username;
      correctCount = scores['correct']!;
      wrongCount = scores['wrong']!;
    });
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
    if (numberA + numberB == int.tryParse(userAnswer)) {
      correctCount++;
      _preferencesService.saveScoreForUser(currentUser, correctCount, wrongCount);
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
      _preferencesService.saveScoreForUser(currentUser, correctCount, wrongCount);
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
      numberA = randomNumber.nextInt(99) + 1;
      numberB = randomNumber.nextInt(99) + 1;
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
        backgroundColor: const Color(0xFFBBDEFB),
        foregroundColor: Colors.black87,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFFFFF3E0),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFC8E6C9),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$numberA + $numberB = $userAnswer',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
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
                    backgroundColor: const Color(0xFFFFECB3),
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
}*/
