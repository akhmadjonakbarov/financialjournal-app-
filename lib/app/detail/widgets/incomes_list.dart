import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/models/income_model.dart';
import 'income_tile.dart';

class IncomesList extends StatefulWidget {
  final List<IncomeModel> incomes;
  final Function(int) onDelete;

  const IncomesList({
    Key? key,
    required this.incomes,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<IncomesList> createState() => _IncomesListState();
}

class _IncomesListState extends State<IncomesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: widget.incomes.length,
      itemBuilder: (context, index) {
        final income = widget.incomes[index];
        return IncomeTile(
          income: income,
          onDelete: widget.onDelete,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}
