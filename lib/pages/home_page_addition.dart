import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_game_for_kids/util/my_button.dart';
import 'package:math_game_for_kids/util/result_message.dart';
import '../preferences_service.dart';
import '../util/base_page.dart'; // Ortak sayfa şablonu

class HomePageAddition extends StatefulWidget {
  const HomePageAddition({super.key});

  @override
  State<HomePageAddition> createState() => _HomePageAdditionState();
}

class _HomePageAdditionState extends State<HomePageAddition> {
  // Sayı tuşları ve özel butonlar
  List<String> numberPad = [
    '1', '2', '3', 'C',
    '4', '5', '6', 'Del',
    '7', '8', '9', '=',
    ' ', '0', ' ',
  ];

  // Sorudaki sayılar ve kullanıcı cevabı
  int numberA = 1;
  int numberB = 1;
  String userAnswer = '';

  // Skorlar
  int correctCount = 0;
  int wrongCount = 0;

  // Kullanıcı adı
  late String currentUser;

  // Servis nesnesi ve rastgele sayı üretici
  final PreferencesService _preferencesService = PreferencesService();
  final Random randomNumber = Random();

  @override
  void initState() {
    super.initState();
    loadUserAndScores(); // kullanıcı bilgileri ve skorları yükle
    numberA = randomNumber.nextInt(99) + 1;
    numberB = randomNumber.nextInt(99) + 1;
  }

  // Kullanıcı adı ve skoru shared_preferences üzerinden getir
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

  // Butonlara tıklanınca yapılacak işlemler
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResult(); // sonucu kontrol et
      } else if (button == 'C') {
        userAnswer = ''; // cevap kutusunu temizle
      } else if (button == 'Del') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1); // son karakteri sil
        }
      } else if (userAnswer.length <= 3) {
        userAnswer += button; // cevap kutusuna sayı ekle
      }
    });
  }

  // Kullanıcının cevabını kontrol et
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

  // Bir sonraki soruya geç
  void goToNextQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
      numberA = randomNumber.nextInt(99) + 1;
      numberB = randomNumber.nextInt(99) + 1;
    });
  }

  // Kullanıcıya tekrar deneme şansı ver
  void goToBackQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // BasePage ile ortak appbar + drawer kullanımı sağlanır
    return BasePage(
      title: "Toplama Oyunu - ✅$correctCount ❌$wrongCount",
      body: Column(
        children: [
          // Soru kutusu
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

          // Numberpad
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
}
