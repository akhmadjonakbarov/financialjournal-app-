import 'package:financialjournal_app/app/detail/pages/add_income_page.dart';

import '../../../utils/money_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../pages/models/Income_model.dart';

class IncomeTile extends StatefulWidget {
  final IncomeModel income;
  const IncomeTile({super.key, required this.income});

  @override
  State<IncomeTile> createState() => _IncomeTileState();
}

class _IncomeTileState extends State<IncomeTile> {
  final MoneyFormatter moneyFormatter = MoneyFormatter();

  void _showControlIncomeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Ink(
                  // width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.error,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      _showDeleteDialog();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'O\'chirish',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Ink(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => AddIncomePage(),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'O\'zgartirish',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rostan ham o\'chirishni istaysizmi?',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Ink(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.error,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Ha',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Ink(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).pop(),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Yo\'q',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onLongPress: _showControlIncomeDialog,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    width: 35,
                    height: 35,
                    child: const Icon(
                      CupertinoIcons.arrow_down,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Kirim",
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${moneyFormatter.formatter(data: widget.income.money)} UZS',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat("HH:MM / dd-MM-y").format(widget.income.dateTime),
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
