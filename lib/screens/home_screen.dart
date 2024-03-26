import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String calculatedResult = '';
  List<double> setOfNumbers = [];
  String currentNumber = '';
  String currentOperator = '';
  void acFunc() {
    setState(() {
      calculatedResult = '';
      setOfNumbers.clear();
      currentNumber = '';
    });
  }

  void add() {
    double result = 0;
    for (int i = 0; i < setOfNumbers.length; i++) {
      result += setOfNumbers[i];
    }
    setState(() {
      calculatedResult = result.toString();
    });
  }

  void multiply() {
    double result = 1; // Initialize result to 1 for multiplication
    for (int i = 0; i < setOfNumbers.length; i++) {
      result *= setOfNumbers[i]; // Multiply each element in the setOfNumbers
    }
    setState(() {
      calculatedResult = result.toString();
    });
  }

  void divide() {
    double result = setOfNumbers.isNotEmpty
        ? setOfNumbers[0]
        : 0; // Initialize result to the first element of setOfNumbers, or 0 if setOfNumbers is empty
    for (int i = 1; i < setOfNumbers.length; i++) {
      if (setOfNumbers[i] != 0) {
        result /= setOfNumbers[i]; // Divide each element in the setOfNumbers
      } else {
        print("Division by zero encountered. Skipping.");
      }
    }
    setState(() {
      calculatedResult = result.toString();
    });
  }

  void subtract() {
    double result = setOfNumbers.isNotEmpty
        ? setOfNumbers[0]
        : 0; // Initialize result to the first element of setOfNumbers, or 0 if setOfNumbers is empty
    for (int i = 1; i < setOfNumbers.length; i++) {
      result -= setOfNumbers[
          i]; // Subtract each element in the setOfNumbers from the result
    }
    setState(() {
      calculatedResult = result.toString();
    });
  }

  void calculateModulus() {
    double result = setOfNumbers.isNotEmpty
        ? setOfNumbers[0]
        : 0; // Initialize result to the first element of setOfNumbers, or 0 if setOfNumbers is empty
    for (int i = 1; i < setOfNumbers.length; i++) {
      if (setOfNumbers[i] != 0) {
        print("calculating modulus ${setOfNumbers[i]}");
        result %= setOfNumbers[
            i]; // Calculate the modulus of result with each element in the setOfNumbers
      } else {
        print("Division by zero encountered. Skipping.");
      }
    }
    setState(() {
      calculatedResult = result.toString();
    });
  }

  void calculateResult() {
    if (setOfNumbers.isNotEmpty) {
      switch (currentOperator) {
        // Add
        case "+":
          add();
          break;
        case "x":
          multiply();
          break;
        case "/":
          divide();
          break;
        case "-":
          subtract();
          break;
        case "%":
          calculateModulus();
          break;
        default:
      }
    } else {
      print("Local numbers is empty!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  calculatedResult,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const Text(
              //   "Result goes here",
              //   style: const TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [
              calculatorCell('AC', Colors.grey[700], acFunc),
              calculatorCell('*/-', Colors.grey[700], () {}),
              calculatorCell('%', Colors.grey[700], () {
                updateResultView('%');
                currentOperator = "%";
                setOfNumbers.add(double.parse(currentNumber));
                setState(() {
                  currentNumber = '';
                });
              }),
              calculatorCell('÷', Colors.orange, () {
                updateResultView('÷');
                currentOperator = "/";
                setOfNumbers.add(double.parse(currentNumber));
                setState(() {
                  currentNumber = '';
                });
              }),
              calculatorCell('7', Colors.grey[500], () {
                updateResultView('7');
                currentNumber += '7';
              }),
              calculatorCell('8', Colors.grey[500], () {
                updateResultView('8');
                currentNumber += '8';
              }),
              calculatorCell('9', Colors.grey[500], () {
                updateResultView('9');
                currentNumber += '9';
              }),
              calculatorCell('x', Colors.orange, () {
                updateResultView('x');
                currentOperator = "x";
                setOfNumbers.add(double.parse(currentNumber));
                setState(() {
                  currentNumber = '';
                });
              }),
              calculatorCell('4', Colors.grey[500], () {
                updateResultView('4');
                currentNumber += '4';
              }),
              calculatorCell('5', Colors.grey[500], () {
                updateResultView('5');
                currentNumber += '5';
              }),
              calculatorCell('6', Colors.grey[500], () {
                updateResultView('6');
                currentNumber += '6';
              }),
              calculatorCell('-', Colors.orange, () {
                updateResultView('-');
                currentOperator = "-";
                setOfNumbers.add(double.parse(currentNumber));
                setState(() {
                  currentNumber = '';
                });
              }),
              calculatorCell('1', Colors.grey[500], () {
                updateResultView('1');
                currentNumber += '1';
              }),
              calculatorCell('2', Colors.grey[500], () {
                updateResultView('2');
                currentNumber += '2';
              }),
              calculatorCell('3', Colors.grey[500], () {
                updateResultView('3');
                currentNumber += '3';
              }),
              calculatorCell('+', Colors.orange, () {
                // add();
                updateResultView("+");
                currentOperator = "+";
                setOfNumbers.add(double.parse(currentNumber));
                setState(() {
                  currentNumber = '0';
                });
              }),
              calculatorCell('0', Colors.grey[500], () {
                updateResultView('0');
                currentNumber += '0';
              }),
              calculatorCell('.', Colors.grey[500], () {
                updateResultView('.');
                currentNumber += '.';
              }),
              calculatorCell('=', Colors.orange, () {
                if (setOfNumbers.isEmpty) {
                  setState(() {
                    currentNumber = '';
                  });
                }
                if (currentNumber.isNotEmpty) {
                  setOfNumbers.add(double.parse(currentNumber));
                }
                calculateResult();
                setOfNumbers.clear();
                setState(() {
                  currentNumber = calculatedResult.toString();
                  // setOfNumbers.add(double.parse(calculatedResult));
                });
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.red,
        child: Center(child: Text("Ads go HERE")),
      ),
    );
  }

  void updateResultView(String value) {
    setState(() {
      if (calculatedResult == '0' && value != '.') {
        calculatedResult = value;
      } else {
        calculatedResult += value;
      }
    });
  }
}

Widget calculatorCell(String cellTitle, Color? cellColor, Function function,
    [Color? textColor = Colors.white]) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () => function(),
      child: Container(
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            cellTitle,
            style: TextStyle(
              fontSize: 45,
              color: textColor,
            ),
          ),
        ),
      ),
    ),
  );
}
