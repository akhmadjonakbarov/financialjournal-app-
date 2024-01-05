import 'package:flutter/material.dart';

import '../../../detail/widgets/custom_app_bar.dart';
import 'widgets/account_month.dart';
import 'widgets/months_list.dart';

class StaticticsPage extends StatefulWidget {
  const StaticticsPage({super.key});

  @override
  State<StaticticsPage> createState() => _StaticticsPageState();
}

class _StaticticsPageState extends State<StaticticsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(text: 'Oylik hisobot'),
            MonthsList(),
            AccountMonth()
          ],
        ),
      ),
    );
  }
}
