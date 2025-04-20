import 'package:converter_app/calculator/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({
    super.key,
  });

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = "";
  var answer = "";
  bool isOperator(String character) {
    return ['+', '-', '*', '/', '%'].contains(character);
  }

  bool canAddOperator() {
    if (userInput.isEmpty) return false;
    String lastChar = userInput[userInput.length - 1];
    return !isOperator(lastChar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                      border:
                          Border.all(color: Colors.grey.shade200, width: 1.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2.r,
                          offset: Offset(0, 4),
                        ),
                      ]),
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: 20.w, left: 20.w, bottom: 14.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            userInput.toString(),
                            style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          answer.toString(),
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      ButtonIcon(
                        title: "AC",
                        onpased: () {
                          userInput = "";
                          answer = "";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "+/-",
                        onpased: () {
                          if (userInput.isNotEmpty) {
                            if (userInput.startsWith("-")) {
                              userInput = userInput.substring(1);
                            } else {
                              userInput = "-$userInput";
                            }
                            setState(() {});
                          }
                        },
                      ),
                      ButtonIcon(
                        title: "%",
                        onpased: () {
                          if (canAddOperator()) {
                            userInput += "%";
                            setState(() {});
                          }
                        },
                      ),
                      ButtonIcon(
                        title: "/",
                        onpased: () {
                          if (canAddOperator()) {
                            userInput += "/";
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ButtonIcon(
                        title: "7",
                        onpased: () {
                          userInput += "7";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "8",
                        onpased: () {
                          userInput += "8";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "0",
                        onpased: () {
                          userInput += "0";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "+",
                        onpased: () {
                          if (canAddOperator()) {
                            userInput += "+";
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ButtonIcon(
                        title: "4",
                        onpased: () {
                          userInput += "4";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "5",
                        onpased: () {
                          userInput += "5";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "6",
                        onpased: () {
                          userInput += "6";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "-",
                        onpased: () {
                          if (canAddOperator()) {
                            userInput += "-";
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ButtonIcon(
                        title: "1",
                        onpased: () {
                          userInput += "1";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "2",
                        onpased: () {
                          userInput += "2";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "3",
                        onpased: () {
                          userInput += "3";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "*",
                        onpased: () {
                          if (canAddOperator()) {
                            userInput += "*";
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ButtonIcon(
                        title: "0",
                        onpased: () {
                          userInput += "0";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: ".",
                        onpased: () {
                          userInput += ".";
                          setState(() {});
                        },
                      ),
                      ButtonIcon(
                        title: "DEL",
                        onpased: () {
                          if (userInput.isNotEmpty) {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                            setState(() {});
                          }
                        },
                      ),
                      ButtonIcon(
                        title: "=",
                        onpased: () {
                          equalPress();

                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void equalPress() {
    try {
      String finalUserInput = userInput.replaceAll('x', '*');
      Parser p = Parser();
      Expression expression = p.parse(finalUserInput);
      ContextModel contextModel = ContextModel();
      double eval = expression.evaluate(EvaluationType.REAL, contextModel);

      // Format answer to remove .0 if it's a whole number
      answer = eval.toString().endsWith(".0")
          ? eval.toInt().toString()
          : eval.toString();
    } catch (e) {
      answer = "Error";
    }
  }
}
