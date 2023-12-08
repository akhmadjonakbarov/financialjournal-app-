import 'package:financialjournal_app/app/detail/pages/models/Income_model.dart';

import 'outlay_tile.dart';

import 'package:flutter/material.dart';

class OutlaysList extends StatefulWidget {
  final List<IncomeModel> outlays;
  const OutlaysList({super.key, required this.outlays});

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
          outlay: outlay,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
