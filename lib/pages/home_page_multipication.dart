import 'dart:math';
import 'package:flutter/material.dart';
import 'package:math_game_for_kids/util/my_button.dart';
import '../const.dart';

class HomePageMul  extends StatefulWidget {
  const HomePageMul ({super.key});

  @override
  State<HomePageMul> createState() => _HomePageState();

}

class _HomePageState extends State<HomePageMul> {
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
    '0',
  ];

  //number A, number B
  int numberA = 1;
  int numberB = 1;
  // String answer
  String userAnswer = '';

  //User tapped the button
  void buttonTapped(String button){
    // print('Tıklanan buton: $button'); // Hangi buton tıklandığını görmek için
    setState(() {
      if(button == '='){
        checkResult();
      }else if(button == 'C'){
        userAnswer = '';
      }else if(button == 'Del'){
        if(userAnswer.isNotEmpty){
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      }else if(userAnswer.length <= 3){
        userAnswer += button;
      }
    });
  }

  //checking the correction
  void checkResult(){
    if(numberA * numberB == int.parse(userAnswer)){
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              backgroundColor: Colors.green,
              content: Container(
                height: 200,
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //the result
                    Text('Correct!', style: WhiteTextStyle),
                    //the button goes to next question

                    GestureDetector(
                      onTap: goToNextQuestion,
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(6),
                          ),

                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                      ),
                    ),

                  ],
                ),
              ),
            );
          });
    }else{
      print('incorrect!');
    }
  }
//create rondom numbers
  var randomNumber = Random();

  @override
  void initState() {
    super.initState();
    numberA = randomNumber.nextInt(9) + 1;
    numberB = randomNumber.nextInt(9) + 1;
  }

  void goToNextQuestion(){
    Navigator.of(context).pop();

    //reset values
    setState(() {
      userAnswer = '';
    });
    //create a new guestion
    numberA = randomNumber.nextInt(9) + 1;
    numberB = randomNumber.nextInt(9) + 1;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Column(
        children: [
          //level progress
          Container(
            height: 140,
            color: Colors.green,
          ),
          // question part
          Expanded(
              child:Container(
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
                          child: Text(
                            userAnswer,
                            style: WhiteTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),

                  itemBuilder: (context, index){
                    return MyButton(
                      child : numberPad[index],
                      onTap : () => buttonTapped(numberPad[index]),
                    );
                  },
                ),
              )


          )
        ],
      ),
    );
  }
}