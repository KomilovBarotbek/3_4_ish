import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String _a = ''; // Birinchi son
  String _b = ''; // Ikkinchi son
  String _oper = ''; // Operator
  String _result = ''; // Natija

  void calculate() {
    // Agar ikkala son ham berilgan bo'lsa, hisoblashni amalga oshirish
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
      _a = _result; // Natijani keyingi hisoblash uchun o'zlashtirish
      _b = '';
      _oper = '';
    }
  }

  void btnPressed(String btnText) {
    setState(() {
      if (btnText == 'C') {
        // Kalkulyatorni tozalash
        _txt.text = '0';
        _a = '';
        _b = '';
        _oper = '';
      } else if (btnText == '+' ||
          btnText == '-' ||
          btnText == 'x' ||
          btnText == '/') {
        // Operatorni tanlash
        if (_a.isNotEmpty && _b.isNotEmpty) {
          calculate(); // Agar ikkinchi son berilgan bo'lsa, avvalgi hisobni yakunlash
        }
        _oper = btnText;
      } else if (btnText == '=') {
        // Hisoblashni yakunlash
        calculate();
      } else {
        // Sonlarni kiritish
        if (_oper.isEmpty) {
          // Birinchi sonni kiritish
          if (_a == '0' && btnText != '.') {
            _a = btnText; // 0 ni boshqarish
          } else {
            _a += btnText;
          }
          _txt.text = _a;
        } else {
          // Ikkinchi sonni kiritish
          if (_b == '0' && btnText != '.') {
            _b = btnText;
          } else {
            _b += btnText;
          }
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
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        btnText,
        style: TextStyle(
          color: textColor,
          fontSize: 24,
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              controller: _txt,
              readOnly: true,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white, fontSize: 48),
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
                createButton('C', Colors.orange, Colors.white24),
                createButton('%', Colors.white, Colors.white24),
                createButton('+/-', Colors.white, Colors.white24),
                createButton('/', Colors.white, Colors.white24),
                createButton('7', Colors.white, Colors.white10),
                createButton('8', Colors.white, Colors.white10),
                createButton('9', Colors.white, Colors.white10),
                createButton('x', Colors.white, Colors.white24),
                createButton('4', Colors.white, Colors.white10),
                createButton('5', Colors.white, Colors.white10),
                createButton('6', Colors.white, Colors.white10),
                createButton('-', Colors.white, Colors.white24),
                createButton('1', Colors.white, Colors.white10),
                createButton('2', Colors.white, Colors.white10),
                createButton('3', Colors.white, Colors.white10),
                createButton('+', Colors.white, Colors.white24),
                createButton('.', Colors.white, Colors.white10),
                createButton('0', Colors.white, Colors.white10),
                createButton('<', Colors.white, Colors.white10),
                createButton('=', Colors.white, Colors.white24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
