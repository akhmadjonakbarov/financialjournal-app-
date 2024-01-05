// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

import 'calculator_button.dart';

class Calculator extends StatefulWidget {
  final String summa;
  final String expressionHistory;
  final Function(String) onGetSumma;
  final Function(String) onGetExpression;

  const Calculator({
    super.key,
    required this.summa,
    required this.expressionHistory,
    required this.onGetSumma,
    required this.onGetExpression,
  });

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final TextEditingController _expressionController = TextEditingController();

  String _summa = '';

  @override
  void initState() {
    _summa = widget.summa;
    _expressionController.text =
        widget.expressionHistory.isEmpty ? '' : widget.expressionHistory;
    super.initState();
  }

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expressionController.clear();
        setState(() {
          _summa = '0.0';
          widget.onGetSumma(_summa);
        });
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'Del') {
        _deleteLast();
      } else {
        _expressionController.text += buttonText;
      }
    });
  }

  void _calculateResult() {
    Parser p = Parser();
    Expression exp = p.parse(_expressionController.text);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      _summa = result.toString();
      widget.onGetSumma(_summa);
      widget.onGetExpression(_expressionController.text);
    });
  }

  void _deleteLast() {
    String currentText = _expressionController.text;
    if (currentText.isNotEmpty) {
      setState(() {
        _expressionController.text =
            currentText.substring(0, currentText.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
            child: Align(
              alignment: Alignment.centerRight,
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      CupertinoIcons.xmark,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _summa,
                    style: GoogleFonts.nunito(
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _expressionController,
                  textAlignVertical: TextAlignVertical.top,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                  ),
                  maxLines: null,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 10),
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 1,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CalculatorButton(
                  onPressed: () => _onPressed(buttons[index]),
                  text: buttons[index],
                );
              },
              itemCount: buttons.length,
            ),
          ),
        ],
      ),
    );
  }
}
