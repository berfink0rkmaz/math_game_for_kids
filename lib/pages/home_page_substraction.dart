import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_game_for_kids/util/my_button.dart';
import 'package:math_game_for_kids/util/result_message.dart';
import '../preferences_service.dart';
import '../util/base_page.dart'; // Ortak sayfa yapısı (AppBar + Drawer içerir)

class HomePageSubstraction extends StatefulWidget {
  const HomePageSubstraction({super.key});

  @override
  State<HomePageSubstraction> createState() => _HomePageSubstractionState();
}

class _HomePageSubstractionState extends State<HomePageSubstraction> {
  // Tuş takımı: rakamlar + C, Del, =
  List<String> numberPad = [
    '1', '2', '3', 'C',
    '4', '5', '6', 'Del',
    '7', '8', '9', '=',
    ' ', '0', ' ',
  ];

  // Sorunun sayıları ve kullanıcı cevabı
  int numberA = 1;
  int numberB = 1;
  String userAnswer = '';

  // Skor sayacı
  int correctCount = 0;
  int wrongCount = 0;

  // Kullanıcı bilgisi
  late String currentUser;

  // Yardımcı servisler
  final PreferencesService _preferencesService = PreferencesService();
  final Random randomNumber = Random();

  @override
  void initState() {
    super.initState();
    loadUserAndScores();   // kullanıcı adı ve skorlarını getir
    generateNewQuestion(); // ilk soruyu oluştur
  }

  // Kullanıcı adına göre doğru/yanlış skorlarını getir
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

  // Yeni çıkarma sorusu üret (negatif olmaması için B < A)
  void generateNewQuestion() {
    numberA = randomNumber.nextInt(99) + 1;
    numberB = randomNumber.nextInt(numberA) + 1;
  }

  // Tuşa basıldığında yapılacak işlemler
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResult(); // kontrol et
      } else if (button == 'C') {
        userAnswer = ''; // sıfırla
      } else if (button == 'Del') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1); // son karakteri sil
        }
      } else if (userAnswer.length <= 3) {
        userAnswer += button; // cevaba sayı ekle
      }
    });
  }

  // Cevabı kontrol et ve sonucu göster
  void checkResult() {
    if (numberA - numberB == int.tryParse(userAnswer)) {
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

  // Yeni bir soru oluştur
  void goToNextQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
      generateNewQuestion();
    });
  }

  // Kullanıcı tekrar deneyecekse
  void goToBackQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // BasePage: Ortak yapı (AppBar + Drawer), sadece içerik burada tanımlanır
    return BasePage(
      title: "Çıkarma Oyunu - ✅$correctCount ❌$wrongCount",
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
              '$numberA - $numberB = $userAnswer',
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
