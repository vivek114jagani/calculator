// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:my_calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("X", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? "" : input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(
                text: "AC",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
              // button(
              //   text: "C",
              //   buttonBgColor: operatorColor,
              //   tColor: orangeColor,
              // ),
              button(
                text: "<",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
              button(
                text: "/",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                text: "X",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                text: "-",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                text: "+",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
            ],
          ),
          Row(
            children: [
              button(
                text: "%",
                buttonBgColor: operatorColor,
                tColor: orangeColor,
              ),
              button(text: "0"),
              button(text: "."),
              button(
                text: "=",
                buttonBgColor: orangeColor,
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget button({
    text,
    tColor = Colors.white,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBgColor,
            padding: const EdgeInsets.all(22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
