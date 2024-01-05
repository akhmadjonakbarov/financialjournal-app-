// ignore_for_file: avoid_print

import 'package:financialjournal_app/app/on_board/pages/home/home_page.dart';
import 'package:financialjournal_app/app/on_board/pages/profile/profile_page.dart';
import 'package:financialjournal_app/app/on_board/pages/statistics/statistics_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  // dart variables
  int _selectedIndex = 0;

  // pages
  List pages = const [
    HomePage(),
    StaticticsPage(),
    ProfilePage(),
  ];

  // flutter variables
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_alt_fill),
            label: 'Hisobot',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
