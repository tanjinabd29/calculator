import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
      } else if (buttonText == '=') {
        _calculateResult();
      } else {
        _output += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      double result = 0.0;
      List<String> operators = ['+', '-', '*', '/'];

      for (String operator in operators) {
        List<String> parts = _output.split(operator);
        if (parts.length == 2) {
          double num1 = double.parse(parts[0]);
          double num2 = double.parse(parts[1]);

          switch (operator) {
            case '+':
              result = num1 + num2;
              break;
            case '-':
              result = num1 - num2;
              break;
            case '*':
              result = num1 * num2;
              break;
            case '/':
              result = num1 / num2;
              break;
          }

          setState(() {
            _output = result.toString();
          });
          return;
        }
      }

      // If no operator is found, display an error.
      setState(() {
        _output = 'Error';
      });
    } catch (e) {
      setState(() {
        _output = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  _buildRow(['7', '8', '9', '/']),
                  _buildRow(['4', '5', '6', '*']),
                  _buildRow(['1', '2', '3', '-']),
                  _buildRow(['0', '.', '=', '+']),
                  _buildRow(['C'], color: Colors.red), // Clear button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> buttons, {Color? color}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons
            .map((buttonText) => ElevatedButton(
          onPressed: () => _onButtonPressed(buttonText),
          style: ButtonStyle(
            backgroundColor: color != null
                ? MaterialStateProperty.all<Color>(color)
                : null,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0),
          ),
        ))
            .toList(),
      ),
    );
  }
}