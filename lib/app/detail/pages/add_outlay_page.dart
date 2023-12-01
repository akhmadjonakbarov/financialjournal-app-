import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../utils/calculator/calculator.dart';

class AddOutlayPage extends StatefulWidget {
  const AddOutlayPage({super.key});

  @override
  State<AddOutlayPage> createState() => _AddOutlayPageState();
}

class _AddOutlayPageState extends State<AddOutlayPage> {
  bool isUZS = true;
  String expressionSum = '0.0';
  String expressionHistory = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDateAndTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, pickedTime.hour, pickedTime.minute);
          selectedTime = pickedTime;
        });
      }
    }
  }

  void getSumma(String summa) {
    setState(() {
      expressionSum = summa;
    });
  }

  void getExpressionHistory(String expression) {
    setState(() {
      expressionHistory = expression;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            height: MediaQuery.sizeOf(context).height * 0.225,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chiqim miqdori:',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '$expressionSum ${isUZS ? 'UZS' : "\$"}',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chiqimlar tarixi:',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      expressionHistory,
                      style: GoogleFonts.nunito(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sana:',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Ink(
                      child: InkWell(
                        onTap: () => _selectDateAndTime(),
                        child: Text(
                          "${DateFormat("dd-MM-y").format(
                            selectedDate.toLocal(),
                          )} ${selectedTime.format(context)}",
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pul turi: ",
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: true,
                              groupValue: isUZS,
                              onChanged: (value) {
                                setState(() {
                                  isUZS = value!;
                                });
                              },
                            ),
                            Text(
                              'UZS',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              value: false,
                              groupValue: isUZS,
                              onChanged: (value) {
                                setState(() {
                                  isUZS = value!;
                                });
                              },
                            ),
                            Text(
                              '\$',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Calculator(
              summa: expressionSum,
              expressionHistory: expressionHistory,
              onGetSumma: getSumma,
              onGetExpression: getExpressionHistory,
            ),
          ),
        ],
      ),
    );
  }
}
