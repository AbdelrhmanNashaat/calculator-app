import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'colors.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNumber = 0.0;
  double secondNumber = 0.0;
  String input = '';
  String output = '';
  String operation = '';
  bool hideInput = false;
  var outPutSize = 40.0;

  onButtonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('X', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel contextModel = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, contextModel);
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }

        input = output;
        hideInput = true;
        outPutSize = 50.0;
      }
    } else {
      input = input + value;
      hideInput = false;
      outPutSize = 40.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(right: 24.0, bottom: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hideInput ? '' : input,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        output,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: outPutSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                button(
                  text: 'AC',
                  txtColor: orangeColor,
                  btnColor: operatorColor,
                ),
                button(
                  text: '<',
                  txtColor: orangeColor,
                  btnColor: operatorColor,
                ),
                button(
                  text: '',
                  btnColor: Colors.transparent,
                ),
                button(
                  text: '/',
                  txtColor: orangeColor,
                  btnColor: operatorColor,
                ),
              ],
            ),
            Row(
              children: [
                button(
                  text: '7',
                ),
                button(
                  text: '8',
                ),
                button(
                  text: '9',
                ),
                button(
                  text: 'X',
                  txtColor: orangeColor,
                  btnColor: operatorColor,
                ),
              ],
            ),
            Row(
              children: [
                button(
                  text: '4',
                ),
                button(
                  text: '5',
                ),
                button(
                  text: '6',
                ),
                button(
                  text: '-',
                  txtColor: orangeColor,
                  btnColor: operatorColor,
                ),
              ],
            ),
            Row(
              children: [
                button(
                  text: '1',
                ),
                button(
                  text: '2',
                ),
                button(
                  text: '3',
                ),
                button(
                  text: '+',
                  txtColor: orangeColor,
                  btnColor: operatorColor,
                ),
              ],
            ),
            Row(
              children: [
                button(
                  text: '%',
                  txtColor: orangeColor,
                  btnColor: operatorColor,
                ),
                button(
                  text: '0',
                ),
                button(
                  text: '.',
                ),
                button(
                  text: '=',
                  btnColor: orangeColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({
    btnColor = buttonColor,
    txtColor = textColor,
    text,
  }) {
    return Expanded(
      child: Container(
        height: 70,
        margin: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.all(12.0),
            backgroundColor: btnColor,
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            '$text',
            style: TextStyle(
              fontSize: 22,
              color: txtColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
