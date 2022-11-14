import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userQuestion = "";
  var userAnswer = "";

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "RND",
    "0",
    ".",
    "="
  ];

  bool allowDot = true;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if (userQuestion.isNotEmpty) {
      for (var i = 0; i < userQuestion.length; i++) {
        if (userQuestion[i] == ".") {
          allowDot = false;
        }
        if (userQuestion[i] == "/" ||
            userQuestion[i] == "%" ||
            userQuestion[i] == "x" ||
            userQuestion[i] == "-" ||
            userQuestion[i] == "+") {
          allowDot = true;
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: w / 22),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: w / 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: w / 22),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: w / 9,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: h < 900 ? 5 : 7,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, -3),
                          color: Colors.white12,
                          blurRadius: 25,
                          spreadRadius: 3)
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(w / 9),
                        topRight: Radius.circular(w / 9))),
                margin: EdgeInsets.only(top: w / 33),
                padding: EdgeInsets.symmetric(horizontal: w / 25),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemCount: buttons.length,
                    itemBuilder: ((context, index) {
                      if (index == 0) {
                        return Button(
                            btn: buttons[index],
                            color: colorPick(index, false),
                            txtColor: Colors.white,
                            shadowColor: colorPick(index, true),
                            buttonTapped: () {
                              clear();
                              allowDot = true;
                            });
                      } else if (index == 1) {
                        return Button(
                            btn: buttons[index],
                            color: colorPick(index, false),
                            txtColor: Colors.white,
                            shadowColor: colorPick(index, true),
                            buttonTapped: () {
                              if (userQuestion.isNotEmpty) {
                                if (userQuestion.length == 1) {
                                  clear();
                                  allowDot = true;
                                } else {
                                  setState(() {
                                    userQuestion = userQuestion.substring(
                                        0, userQuestion.length - 1);
                                    if (userQuestion.isNotEmpty) {
                                      if (!isOprator(userQuestion[
                                          userQuestion.length - 1])) {
                                        equalParsed();
                                      }
                                    }
                                  });
                                }
                              }
                            });
                      } else if (index == buttons.length - 1) {
                        return Button(
                            btn: buttons[index],
                            color: colorPick(index, false),
                            txtColor: Colors.white,
                            shadowColor: colorPick(index, true),
                            buttonTapped: () {
                              if (userQuestion.isEmpty) {
                              } else {
                                if (isOprator(
                                    userQuestion[userQuestion.length - 1])) {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                  equalParsed();
                                } else {
                                  equalParsed();
                                }
                              }
                            });
                      } else if (index == buttons.length - 2) {
                        return Button(
                            btn: buttons[index],
                            color: colorPick(index, false),
                            txtColor: Colors.white,
                            shadowColor: colorPick(index, true),
                            buttonTapped: () {
                              if (userQuestion.isNotEmpty) {
                                bool isDouble = !allowDot;
                                if (!isDouble) {
                                  if (isOprator(
                                      userQuestion[userQuestion.length - 1])) {
                                    setState(() {
                                      userQuestion += "0.";
                                    });
                                  } else if (userQuestion[
                                          userQuestion.length - 1] !=
                                      ".") {
                                    setState(() {
                                      userQuestion += buttons[index];
                                    });
                                  }
                                }
                              } else {
                                setState(() {
                                  userQuestion += "0.";
                                });
                              }
                            });
                      } else if (index == buttons.length - 4) {
                        return Button(
                            btn: buttons[index],
                            color: colorPick(index, false),
                            txtColor: Colors.white,
                            shadowColor: colorPick(index, true),
                            buttonTapped: () {
                              if (userQuestion.isNotEmpty) {
                                bool isDouble = userQuestion.contains(".");

                                if (isDouble) {
                                  List<String> splitted = [];
                                  splitted = userAnswer.split(".");
                                  setState(() {
                                    userAnswer = splitted[0];
                                  });
                                }
                              }
                            });
                      } else if (index == buttons.length - 3) {
                        return Button(
                            btn: buttons[index],
                            color: colorPick(index, false),
                            txtColor: Colors.white,
                            shadowColor: colorPick(index, true),
                            buttonTapped: () {
                              if (userQuestion.isNotEmpty) {
                                if (userQuestion.length == 1) {
                                  if (userQuestion[userQuestion.length - 1] !=
                                      "0") {
                                    setState(() {
                                      userQuestion += buttons[index];
                                    });
                                  }
                                } else {
                                  setState(() {
                                    userQuestion += buttons[index];
                                  });
                                }
                              } else {
                                setState(() {
                                  userQuestion += buttons[index];
                                });
                              }
                            });
                      } else {
                        return Button(
                            btn: buttons[index],
                            color: colorPick(index, false),
                            txtColor: Colors.white,
                            shadowColor: colorPick(index, true),
                            buttonTapped: () {
                              setState(() {
                                if (userQuestion.isEmpty) {
                                  if (!isOprator(buttons[index])) {
                                    userQuestion += buttons[index];
                                    equalParsed();
                                  }
                                } else {
                                  if (!isOprator(
                                      userQuestion[userQuestion.length - 1])) {
                                    userQuestion += buttons[index];
                                    isOprator(buttons[index])
                                        ? () {}
                                        : equalParsed();
                                  } else {
                                    if (isOprator(buttons[index])) {
                                      userQuestion = userQuestion.substring(
                                          0, userQuestion.length - 1);
                                      userQuestion += buttons[index];
                                    } else {
                                      userQuestion += buttons[index];
                                      equalParsed();
                                    }
                                  }
                                }
                              });
                            });
                      }
                    }))),
          )
        ],
      ),
    );
  }

  bool isOprator(String x) {
    if (x == "-" ||
        x == "+" ||
        x == "x" ||
        x == "/" ||
        x == "=" ||
        x == "%" ||
        x == "RND") {
      return true;
    }
    return false;
  }

  void clear() {
    setState(() {
      userQuestion = "";
      userAnswer = "";
    });
  }

  void equalParsed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      if (eval % 1 == 0.0) {
        userAnswer = eval.toInt().toString();
      } else {
        userAnswer = eval.toStringAsFixed(6);
        for (var i = userAnswer.length - 1; i >= 0; i--) {
          if (userAnswer[i] == "0") {
            userAnswer = userAnswer.substring(0, userAnswer.length - 1);
          } else {
            return;
          }
        }
      }
    });
  }

  Color colorPick(int index, bool isShadow) {
    return isShadow
        ? index == 0
            ? Colors.green.shade400
            : index == 1
                ? Colors.red.shade400
                : isOprator(buttons[index])
                    ? Colors.amber.shade400
                    : Colors.grey.shade400
        : index == 0
            ? Colors.green
            : index == 1
                ? Colors.red
                : isOprator(buttons[index])
                    ? Colors.amber
                    : Colors.grey.shade400;
  }
}
