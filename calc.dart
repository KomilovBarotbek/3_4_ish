import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final TextEditingController _txt = TextEditingController(text: "0");
  String _a = '';
  String _b = '';
  String _oper = '';
  String _result = '';

  void calculate() {
    if (_a.isNotEmpty && _b.isNotEmpty && _oper.isNotEmpty) {
      double a = double.tryParse(_a) ?? 0;
      double b = double.tryParse(_b) ?? 0;
      switch (_oper) {
        case '+':
          _result = (a + b).toString();
          break;
        case '-':
          _result = (a - b).toString();
          break;
        case 'x':
          _result = (a * b).toString();
          break;
        case '/':
          _result = (b != 0) ? (a / b).toString() : 'Error';
          break;
        default:
          _result = 'Error';
      }
      _txt.text = _result;
      _a = _result;
      _b = '';
      _oper = '';
    }
  }

  void btnPressed(String btnText) {
    setState(() {
      if (btnText == 'C') {
        _txt.text = '0';
        _a = '';
        _b = '';
        _oper = '';
      } else if (btnText == '<') {
        if (_oper.isEmpty) {
          _a = _a.isNotEmpty ? _a.substring(0, _a.length - 1) : '';
          _txt.text = _a.isEmpty ? '0' : _a;
        } else {
          _b = _b.isNotEmpty ? _b.substring(0, _b.length - 1) : '';
          _txt.text = _b.isEmpty ? '0' : _b;
        }
      } else if (btnText == '+/-') {
        if (_oper.isEmpty) {
          _a = _a.startsWith('-') ? _a.substring(1) : '-$_a';
          _txt.text = _a;
        } else {
          _b = _b.startsWith('-') ? _b.substring(1) : '-$_b';
          _txt.text = _b;
        }
      } else if (btnText == '%') {
        if (_oper.isEmpty && _a.isNotEmpty) {
          double a = double.tryParse(_a) ?? 0;
          _a = (a / 100).toString();
          _txt.text = _a;
        } else if (_b.isNotEmpty) {
          double b = double.tryParse(_b) ?? 0;
          _b = (b / 100).toString();
          _txt.text = _b;
        }
      } else if (btnText == '+' ||
          btnText == '-' ||
          btnText == 'x' ||
          btnText == '/') {
        if (_a.isNotEmpty && _b.isNotEmpty) {
          calculate();
        }
        _oper = btnText;
      } else if (btnText == '=') {
        calculate();
      } else {
        if (_oper.isEmpty) {
          _a = _a == '0' ? btnText : _a + btnText;
          _txt.text = _a;
        } else {
          _b = _b == '0' ? btnText : _b + btnText;
          _txt.text = _b;
        }
      }
    });
  }

  Widget createButton(String btnText, Color textColor, Color bgColor) {
    return ElevatedButton(
      onPressed: () => btnPressed(btnText),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1),
        ),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        btnText,
        style: TextStyle(
          color: textColor,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
            child: TextField(
              controller: _txt,
              readOnly: true,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w300,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              padding: const EdgeInsets.all(8),
              children: [
                createButton('C', Colors.orange, Colors.grey[850]!),
                createButton('%', Colors.white, Colors.grey[850]!),
                createButton('+/-', Colors.white, Colors.grey[850]!),
                createButton('/', Colors.white, Colors.grey[850]!),
                createButton('7', Colors.white, Colors.grey[800]!),
                createButton('8', Colors.white, Colors.grey[800]!),
                createButton('9', Colors.white, Colors.grey[800]!),
                createButton('x', Colors.white, Colors.grey[850]!),
                createButton('4', Colors.white, Colors.grey[800]!),
                createButton('5', Colors.white, Colors.grey[800]!),
                createButton('6', Colors.white, Colors.grey[800]!),
                createButton('-', Colors.white, Colors.grey[850]!),
                createButton('1', Colors.white, Colors.grey[800]!),
                createButton('2', Colors.white, Colors.grey[800]!),
                createButton('3', Colors.white, Colors.grey[800]!),
                createButton('+', Colors.white, Colors.grey[850]!),
                createButton('.', Colors.white, Colors.grey[800]!),
                createButton('0', Colors.white, Colors.grey[800]!),
                createButton('<', Colors.white, Colors.grey[800]!),
                createButton('=', Colors.white, Colors.grey[850]!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
