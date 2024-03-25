import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String localResult = '0';
  List<double> localNumbers = [];
  double currentNumber = 0;

  void acFunc() {
    setState(() {
      localResult = '0';
      localNumbers.clear();
      currentNumber = 0;
    });
  }

  void add() {
    localNumbers.add(double.parse(localResult));
    setState(() {
      currentNumber = 0;
      localResult = '0';
    });
  }

  void multiply() {
    localNumbers.add(double.parse(localResult));
    setState(() {
      currentNumber = 0;
      localResult = '0';
    });
  }

  void calculateResult() {
    if (localNumbers.isNotEmpty) {
      localNumbers.add(double.parse(localResult));
      double result = localNumbers.reduce((value, element) => value + element);
      setState(() {
        localResult = result.toString();
        localNumbers.clear();
        currentNumber = result;
      });
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
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localResult,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Result goes here",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [
              calculatorCell('AC', Colors.grey[700], acFunc),
              calculatorCell('*/-', Colors.grey[700], () {}),
              calculatorCell('%', Colors.grey[700], () {}),
              calculatorCell('÷', Colors.orange, () {
                add();
              }),
              calculatorCell('7', Colors.grey[500], () {
                updateLocalResult('7');
              }),
              calculatorCell('8', Colors.grey[500], () {
                updateLocalResult('8');
              }),
              calculatorCell('9', Colors.grey[500], () {
                updateLocalResult('9');
              }),
              calculatorCell('x', Colors.orange, () {
                multiply();
              }),
              calculatorCell('4', Colors.grey[500], () {
                updateLocalResult('4');
              }),
              calculatorCell('5', Colors.grey[500], () {
                updateLocalResult('5');
              }),
              calculatorCell('6', Colors.grey[500], () {
                updateLocalResult('6');
              }),
              calculatorCell('-', Colors.orange, () {
                updateLocalResult('-');
              }),
              calculatorCell('1', Colors.grey[500], () {
                updateLocalResult('1');
              }),
              calculatorCell('2', Colors.grey[500], () {
                updateLocalResult('2');
              }),
              calculatorCell('3', Colors.grey[500], () {
                updateLocalResult('3');
              }),
              calculatorCell('+', Colors.orange, () {
                add();
              }),
              calculatorCell('0', Colors.grey[500], () {
                updateLocalResult('0');
              }),
              calculatorCell('.', Colors.grey[500], () {
                updateLocalResult('.');
              }),
              calculatorCell('=', Colors.orange, () {
                calculateResult();
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const SizedBox(
        height: 150,
      ),
    );
  }

  void updateLocalResult(String value) {
    setState(() {
      if (localResult == '0' && value != '.') {
        localResult = value;
      } else {
        localResult += value;
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
