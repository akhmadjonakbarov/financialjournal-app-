import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

import 'calculator_button.dart';

class Calculator extends StatefulWidget {
  String summa;
  String expressionHistory;
  Function(String) onGetSumma;
  Function(String) onGetExpression;

  Calculator({
    required this.summa,
    required this.expressionHistory,
    required this.onGetSumma,
    required this.onGetExpression,
  });

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController _expressionController = TextEditingController();

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
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    _summa,
                    style: GoogleFonts.nunito(
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _expressionController,
                  textAlignVertical: TextAlignVertical.bottom,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                  ),
                  maxLines: 2,
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
              padding: EdgeInsets.only(bottom: 10),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: MediaQuery.sizeOf(context).height * 0.00155,
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
