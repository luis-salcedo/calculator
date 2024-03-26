import 'package:calculator/utils/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  String calculatedResult = '';
  List<double> setOfNumbers = [];
  String currentNumber = '';
  String currentOperator = '';

  /// Loads a banner ad.
  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    loadAd();
  }

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

  //IS Broken?
  void positiveNegative() {
    if (currentNumber.isNotEmpty || setOfNumbers.isNotEmpty) {
      print("CURRENT NUMBER: $currentNumber");
      double cNumber = double.parse(currentNumber);

      // Find the position of the current number within calculatedResult
      int startIndex = calculatedResult.lastIndexOf(currentNumber);

      setState(() {
        if (startIndex != -1) {
          // Check if currentNumber is found
          if (cNumber.isNegative) {
            // Convert negative to positive
            double convertedToPositive = cNumber.abs();
            // Replace the currentNumber with its positive equivalent
            calculatedResult = calculatedResult.replaceRange(
                startIndex,
                startIndex + currentNumber.length,
                convertedToPositive.toStringAsFixed(0));
            currentNumber = convertedToPositive.toString();
          } else {
            // Convert positive to negative
            double convertedToNegative = -cNumber;
            // Replace the currentNumber with its negative equivalent
            calculatedResult = calculatedResult.replaceRange(
                startIndex,
                startIndex + currentNumber.length,
                convertedToNegative.toStringAsFixed(0));
            currentNumber = convertedToNegative.toString();
          }
        } else {
          // Handle case where currentNumber is not found
          print("Current number not found in calculatedResult.");
        }
      });
    }
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
              calculatorCell('*/-', Colors.grey[700], () {
                if (currentNumber.isNotEmpty || setOfNumbers.isNotEmpty) {
                  positiveNegative();
                }
              }),
              calculatorCell('%', Colors.grey[700], () {
                if (currentNumber.isNotEmpty || setOfNumbers.isNotEmpty) {
                  updateResultView('%');
                  currentOperator = "%";
                  setOfNumbers.add(double.parse(currentNumber));
                  setState(() {
                    currentNumber = '';
                  });
                }
              }),
              calculatorCell('÷', Colors.orange, () {
                if (currentNumber.isNotEmpty || setOfNumbers.isNotEmpty) {
                  updateResultView('÷');
                  currentOperator = "/";
                  setOfNumbers.add(double.parse(currentNumber));
                  setState(() {
                    currentNumber = '';
                  });
                }
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
                if (currentNumber.isNotEmpty || setOfNumbers.isNotEmpty) {
                  updateResultView('x');
                  currentOperator = "x";
                  setOfNumbers.add(double.parse(currentNumber));
                  setState(() {
                    currentNumber = '';
                  });
                }
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
                if (currentNumber.isNotEmpty || setOfNumbers.isNotEmpty) {
                  updateResultView('-');
                  currentOperator = "-";
                  setOfNumbers.add(double.parse(currentNumber));
                  setState(() {
                    currentNumber = '';
                  });
                }
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
                if (currentNumber.isNotEmpty || setOfNumbers.isNotEmpty) {
                  updateResultView("+");
                  currentOperator = "+";
                  setOfNumbers.add(double.parse(currentNumber));
                  setState(() {
                    currentNumber = '';
                  });
                }
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
      bottomNavigationBar: _bannerAd != null
          ? SizedBox(
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          : Container(),
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
