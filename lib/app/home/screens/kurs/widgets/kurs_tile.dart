import 'package:financialjournal_app/app/common/models/kurs_model.dart';
import 'package:financialjournal_app/utils/money_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils/custom_date_formatter.dart';

class KursTile extends StatelessWidget {
  final KursModel kurs;

  KursTile({super.key, required this.kurs});

  MoneyFormatter moneyFormatter = MoneyFormatter();
  String formattedKurs = '';

  @override
  Widget build(BuildContext context) {
    formattedKurs = moneyFormatter.formatter(data: kurs.currency).toString();
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'USD',
                style: GoogleFonts.nunito(fontSize: 22),
              ),
              Text(
                "1 USD = $formattedKurs UZS",
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            dateFormatter(kurs.createdAt),
            style: GoogleFonts.nunito(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
