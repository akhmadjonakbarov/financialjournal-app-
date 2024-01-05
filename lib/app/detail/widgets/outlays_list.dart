import '../pages/models/income_model.dart';

import 'outlay_tile.dart';

import 'package:flutter/material.dart';

class OutlaysList extends StatefulWidget {
  final List<IncomeModel> outlays;
  final Function(int) onDelete;

  const OutlaysList({
    super.key,
    required this.outlays,
    required this.onDelete,
  });

  @override
  State<OutlaysList> createState() => _OutlaysListState();
}

class _OutlaysListState extends State<OutlaysList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: widget.outlays.length,
      itemBuilder: (context, index) {
        IncomeModel outlay = widget.outlays[index];
        return OutlayTile(
          onDelete: widget.onDelete,
          outlay: outlay,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
