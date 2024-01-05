import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/money_formatter.dart';

class ShowAccount extends StatelessWidget {
  final double sum_;
  ShowAccount({super.key, required this.sum_});
  final MoneyFormatter moneyFormatter = MoneyFormatter();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(
            10,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'Hisob',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '${moneyFormatter.formatter(data: sum_)} UZS',
              style: GoogleFonts.nunito(
                fontSize: 28.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
