import 'outlay_tile.dart';

import 'package:flutter/material.dart';

class OutlaysList extends StatelessWidget {
  const OutlaysList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: 5,
      itemBuilder: (context, index) {
        return OutlayTile();
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
