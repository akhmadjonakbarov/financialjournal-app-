import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/login/login_screen.dart';
import 'screens/register/register_screen.dart';
import 'widgets/auth_button.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Stack(
                      children: [
                        Container(
                            height: MediaQuery.sizeOf(context).height * 0.52,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(27),
                              ),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  decoration: const BoxDecoration(),
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                  ),
                                );
                              },
                            )),
                        Positioned(
                          top: 15,
                          left: 15,
                          child: Text(
                            'Financial\nJourney',
                            style: GoogleFonts.roboto(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.02,
                      bottom: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    child: Text(
                      'Smart Finances',
                      style: GoogleFonts.roboto(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'With all the tools you need, our financial app is designed to help you manage your money, track your expenses, and achieve your financial goals with ease.',
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.01),
                    child: Column(
                      children: [
                        AuthButton(
                          title: 'Boshlash',
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ));
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AuthButton(
                          title: 'Kirish',
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
