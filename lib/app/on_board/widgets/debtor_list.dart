import 'package:flutter/widgets.dart';

import '../models/debtor_model.dart';
import 'debtor_tile.dart';

class DebtorList extends StatelessWidget {
  final List<DebtorModel> debtors;
  const DebtorList({super.key, required this.debtors});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: debtors.length,
        itemBuilder: (context, index) {
          DebtorModel debtor = debtors[index];
          return DebtorTile(
            debtor: debtor,
          );
        },
      ),
    );
  }
}
