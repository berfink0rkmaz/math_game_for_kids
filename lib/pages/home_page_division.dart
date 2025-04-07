import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_game_for_kids/util/my_button.dart';
import 'package:math_game_for_kids/util/result_message.dart';
import '../custom_drawer.dart';
import '../preferences_service.dart';

class HomePageDivision extends StatefulWidget {
  const HomePageDivision({super.key});

  @override
  State<HomePageDivision> createState() => _HomePageDivisionState();
}

class _HomePageDivisionState extends State<HomePageDivision> {
  // Ekranda gösterilecek sayı butonları
  List<String> numberPad = [
    '1', '2', '3', 'C',
    '4', '5', '6', 'Del',
    '7', '8', '9', '=',
    ' ', '0', ' ',
  ];

  // İşlem için kullanılacak sayılar ve kullanıcı cevabı
  int numberA = 1;
  int numberB = 1;
  String userAnswer = '';

  // Doğru/yanlış sayaçları
  int correctCount = 0;
  int wrongCount = 0;

  // Giriş yapan kullanıcı
  late String currentUser;

  // Yardımcı sınıflar
  final PreferencesService _preferencesService = PreferencesService();
  final Random randomNumber = Random();

  @override
  void initState() {
    super.initState();
    loadUserAndScores(); // kullanıcı adı ve skorları yükle
    generateNewQuestion(); // ilk soru oluştur
  }

  // Kullanıcıya özel skorları shared preferences'tan yükle
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

  // Tam bölünebilen yeni bir bölme sorusu oluştur
  void generateNewQuestion() {
    numberB = randomNumber.nextInt(9) + 1; // bölen (0 olmasın)
    int result = randomNumber.nextInt(9) + 1; // sonuç
    numberA = numberB * result; // bölünen = bölen × sonuç
  }

  // Kullanıcının butonlara tıklamasını işler
  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        checkResult(); // sonucu kontrol et
      } else if (button == 'C') {
        userAnswer = ''; // tüm cevabı temizle
      } else if (button == 'Del') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1); // son karakteri sil
        }
      } else if (userAnswer.length <= 3) {
        userAnswer += button; // sayı ekle
      }
    });
  }

  // Cevabı kontrol et ve sonucu göster
  void checkResult() {
    if (numberA ~/ numberB == int.tryParse(userAnswer)) {
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

  // Yeni soruya geç
  void goToNextQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
      generateNewQuestion();
    });
  }

  // Aynı soruyu tekrar göster
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
              '$numberA ÷ $numberB = $userAnswer',
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