// ignore_for_file: avoid_print

import 'package:financialjournal_app/app/home/widgets/profile_app_bar.dart';
import 'package:financialjournal_app/app/home/widgets/debtor_tile.dart';
import 'package:financialjournal_app/utils/check_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String time;

  @override
  void initState() {
    setState(() {
      time = checkTime();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ProfileAppBar(time: time),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const DebtorTile();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
