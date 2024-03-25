class Calculator {
  double _result = 0;

  double get result => _result;

  void reset() {
    _result = 0;
  }

  void addNumbers(List<double> numbers) {
    for (var number in numbers) {
      _result += number;
    }
  }

  void subtractNumbers(List<double> numbers) {
    if (numbers.isNotEmpty) {
      _result = numbers.first;
      for (int i = 1; i < numbers.length; i++) {
        _result -= numbers[i];
      }
    }
  }

  void multiplyNumbers(List<double> numbers) {
    _result = 1;
    for (var number in numbers) {
      _result *= number;
    }
  }

  void divideNumbers(List<double> numbers) {
    if (numbers.isNotEmpty) {
      _result = numbers.first;
      for (int i = 1; i < numbers.length; i++) {
        if (numbers[i] != 0) {
          _result /= numbers[i];
        } else {
          // Handle division by zero error
          _result = double.infinity; // Set result to infinity
          break; // Exit loop
        }
      }
    }
  }
}
