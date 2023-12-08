import 'package:financialjournal_app/app/detail/pages/models/Income_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'income_tile.dart';

class IncomesList extends StatelessWidget {
  final List<IncomeModel> incomes;
  const IncomesList({super.key, required this.incomes});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: incomes.length,
      itemBuilder: (context, index) {
        IncomeModel income = incomes[index];
        return IncomeTile(
          income: income,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
