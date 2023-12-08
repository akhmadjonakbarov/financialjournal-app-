import 'package:financialjournal_app/app/detail/pages/models/Income_model.dart';

import '../../../utils/money_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OutlayTile extends StatelessWidget {
  final IncomeModel outlay;
  OutlayTile({super.key, required this.outlay});

  final MoneyFormatter moneyFormatter = MoneyFormatter();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(16)),
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
                  CupertinoIcons.arrow_up,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Chiqim",
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
                '${moneyFormatter.formatter(data: outlay.money)} UZS',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                DateFormat("HH:MM / dd-MM-y").format(
                  outlay.dateTime,
                ),
                style: GoogleFonts.nunito(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
