import 'dart:developer';

import 'package:financialjournal_app/app/detail/pages/add_income_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../contants/app_icons.dart';
import '../../../utils/calculator/calculator.dart';
import '../../common/controllers/blocs/kurs/kurs_bloc.dart';
import '../../common/models/kurs_model.dart';
import '../widgets/custom_app_bar.dart';
import 'controllers/blocs/income_or_outlay_bloc.dart';
import 'models/income_model.dart';
import 'widgets/save_button.dart';
import 'widgets/show_summa.dart';

class AddOutlayPage extends StatefulWidget {
  final int? debtorId;
  final bool? isUpdate;
  const AddOutlayPage({super.key, this.debtorId, this.isUpdate = false});

  @override
  State<AddOutlayPage> createState() => _AddOutlayPageState();
}

class _AddOutlayPageState extends State<AddOutlayPage> {
  bool isUZS = true;
  String expressionSum = '0.0';
  String expressionHistory = '';
  DateTime selectedDate = DateTime.now();
  IncomeModel? outlay;

  Map<String, dynamic> outlayAddingData = {
    'money': '',
    'expression_history': '',
    'currency_convert': 0,
    'currency_id': 0,
    'status': 1,
    'debtor_id': 0,
    'date': DateTime.now()
  };

  @override
  void didChangeDependencies() {
    setState(() {
      outlay = ModalRoute.of(context)!.settings.arguments as IncomeModel?;
    });
    if (outlay != null) {
      outlayAddingData['debtor_id'] = outlay!.debtorId;
      expressionHistory = outlay!.expressionHistory;
      expressionSum = outlay!.money.toString();
      isUZS = outlay!.currencyConvert == 0 ? true : false;
    }
    outlayAddingData['debtor_id'] =
        widget.debtorId != null ? widget.debtorId! : -1;
    super.didChangeDependencies();
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
      outlayAddingData['date'] = selectedDate;
    }
  }

  void getSumma(String summa) {
    if (summa.isNotEmpty) {
      setState(() {
        expressionSum = summa;
        outlayAddingData['money'] = double.parse(expressionSum);
      });
    }
  }

  void getExpressionHistory(String expression) {
    if (expression.isNotEmpty) {
      setState(() {
        expressionHistory = expression;
        outlayAddingData['expression_history'] = expressionHistory;
      });
    }
  }

  void isConverted(bool isConverted) async {
    KursModel kurs;
    KursBloc kursBloc = KursBloc();
    if (isConverted) {
      kurs = await kursBloc.getSingleKurs();
      setState(() {
        outlayAddingData['currency_convert'] = 1;
        outlayAddingData['currency_id'] = kurs.id;
      });
    }
  }

  void _save() {
    if (widget.isUpdate!) {
      log("$outlayAddingData");
      context.read<IncomeOrOutlayBloc>().add(
            IncomeOrOutlayUpdateEvent(
              id: outlay!.id,
              debtorId: outlayAddingData['debtor_id'],
              currencyId: outlayAddingData['currency_id'],
              currencyConvert: outlayAddingData['currency_convert'],
              expressionHistory: outlayAddingData['expression_history'],
              money: outlayAddingData['money'],
              dateTime: outlayAddingData['date'],
              status: 1,
            ),
          );
      final bloc = context.read<IncomeOrOutlayBloc>();
      bloc.add(OutlayGetEvent(debtorId: widget.debtorId!));
      Navigator.of(context).pop();
    } else {
      context.read<IncomeOrOutlayBloc>().add(
            IncomeAddEvent(
              debtorId: outlayAddingData['debtor_id'],
              currencyId: outlayAddingData['currency_id'],
              currencyConvert: outlayAddingData['currency_convert'],
              expressionHistory: outlayAddingData['expression_history'],
              money: outlayAddingData['money'],
              dateTime: outlayAddingData['date'],
              status: 1,
            ),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
          content: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(),
            height: 35,
            child: Text(
              "Chiqim qo'shildi!",
              style: GoogleFonts.nunito(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    }
  }

  void showCalculator() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Calculator(
          summa: expressionSum,
          expressionHistory: expressionHistory,
          onGetSumma: getSumma,
          onGetExpression: getExpressionHistory,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (widget.isUpdate!)
              const CustomAppBar(
                text: 'Tranzaksiyani tahrirlash',
                isBackButton: true,
              ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  ShowSumma(
                    expressionSum: expressionSum,
                    isUZS: isUZS,
                    label: 'Chiqim',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ShowExpressionHisotory(
                    expressionHistory: expressionHistory,
                    label: 'Chiqimlar',
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
                            DateFormat("dd-MM-y").format(
                              selectedDate.toLocal(),
                            ),
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
                  SaveButton(
                    onTap: _save,
                    isUpdate: widget.isUpdate!,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCalculator,
        child: SvgPicture.asset(
          AppIcons.calculator,
        ),
      ),
    );
  }
}
