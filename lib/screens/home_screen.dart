import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          const Text(
            "Text Here",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [
              calculatorCell('AC', Colors.grey[700], () {}),
              calculatorCell('*/-', Colors.grey[700], () {}),
              calculatorCell('%', Colors.grey[700], () {}),
              calculatorCell('/', Colors.orange, () {}),

              calculatorCell('7', Colors.grey[500], () {}),
              calculatorCell('8', Colors.grey[500], () {}),
              calculatorCell('9', Colors.grey[500], () {}),
              calculatorCell('X', Colors.orange, () {}),

              calculatorCell('4', Colors.grey[500], () {}),
              calculatorCell('5', Colors.grey[500], () {}),
              calculatorCell('6', Colors.grey[500], () {}),
              calculatorCell('-', Colors.orange, () {}),

              calculatorCell('1', Colors.grey[500], () {}),
              calculatorCell('2', Colors.grey[500], () {}),
              calculatorCell('3', Colors.grey[500], () {}),
              calculatorCell('+', Colors.orange, () {}),

              calculatorCell('0', Colors.grey[500], () {}),
              calculatorCell('.', Colors.grey[500], () {}),
              calculatorCell('=', Colors.orange, () {}),

              // calculatorCell("8", () {}),
              // calculatorCell("9", () {}),
              // calculatorCell("/", () {}),
              // calculatorCell("4", () {}),
              // calculatorCell("5", () {}),
              // calculatorCell("6", () {}),
              // calculatorCell("X", () {}),
              // calculatorCell("1", () {}),
              // calculatorCell("2", () {}),
              // calculatorCell("3", () {}),
              // calculatorCell("-", () {}),
              // calculatorCell("0", () {}),
              // calculatorCell(".", () {}),
              // calculatorCell("=", () {}),
              // calculatorCell("+", () {}),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const SizedBox(
        height: 150,
      ),
    );
  }
}

Widget calculatorCell(String cellTitle, Color? cellColor, Function function,
    [Color? textColor = Colors.white]) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: function(),
      child: Container(
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          cellTitle,
          style: TextStyle(
            color: textColor,
          ),
        )),
      ),
    ),
  );
}
