import 'package:financialjournal_app/app/authentication/authentication_screen.dart';
import 'package:financialjournal_app/app/authentication/screens/login/login_screen.dart';
import 'package:financialjournal_app/app/authentication/screens/register/register_screen.dart';
import 'package:financialjournal_app/app/detail/detial_screen.dart';
import 'package:financialjournal_app/app/home/home_screen.dart';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial App',
      home: DetailScreen(),
    );
  }
}
