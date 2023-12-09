import 'package:financialjournal_app/app/detail/pages/controllers/blocs/income_or_outlay_bloc.dart';
import 'package:financialjournal_app/app/home/models/debtor_model.dart';
import 'package:financialjournal_app/utils/calculator/calculator.dart';
import 'package:financialjournal_app/utils/custom_date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

enum Currency { USD, UZS }

class AddIncomePage extends StatefulWidget {
  DebtorModel? debtor;
  AddIncomePage({super.key, this.debtor});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  bool isUZS = true;
  String expressionSum = '0.0';
  String expressionHistory = '';
  DateTime? selectedDate;

  Map<String, dynamic> incomeAddingData = {
    'money': '',
    'expression_history': '',
    'currency_convert': 0,
    'currency_id': 0,
    'status': 0,
    'debtor_id': 0,
    'date': DateTime.now()
  };

  @override
  void initState() {
    incomeAddingData['debtor_id'] = widget.debtor != null ? widget.debtor!.id : -1;
    super.initState();
  }

  Future<void> _selectDateAndTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      if (selectedDate != null) {
        incomeAddingData['date'] = selectedDate;
      }
    }
  }

  void getSumma(String summa) {
    if (summa.isNotEmpty) {
      setState(() {
        expressionSum = summa;
        incomeAddingData['money'] = double.parse(expressionSum);
      });
    }
  }

  void getExpressionHistory(String expression) {
    if (expression.isNotEmpty) {
      setState(() {
        expressionHistory = expression;
        incomeAddingData['expression_history'] = expressionHistory;
      });
    }
  }

  void isConverted(bool isConverted) {
    if (isConverted) {
      incomeAddingData['currency_convert'] = 1;
    }
  }

  void _save() {
    context.read<IncomeOrOutlayBloc>().add(
          IncomeAddEvent(
            debtorId: incomeAddingData['debtor_id'],
            currencyId: incomeAddingData['currency_id'],
            currencyConvert: incomeAddingData['currency_convert'],
            expressionHistory: incomeAddingData['expression_history'],
            money: incomeAddingData['money'],
            dateTime: incomeAddingData['date'],
            status: 0,
          ),
        );
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
                      'Kirim miqdori:',
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kirimlar tarixi:',
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
                        child: selectedDate == null
                            ? Text(
                                'Sanani tanlang',
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Text(
                                dateFormatter(selectedDate!),
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
                                isConverted(true);
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
                Ink(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: _save,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Saqlash',
                        style: GoogleFonts.nunito(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                )
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
