import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'income_tile.dart';

class IncomesList extends StatelessWidget {
  const IncomesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: 25,
      itemBuilder: (context, index) {
        return IncomeTile();
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
