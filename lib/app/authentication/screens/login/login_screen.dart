// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:financialjournal_app/app/authentication/controllers/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  Map<String, dynamic> loginData = {
    'phone': '',
    'password': '',
  };

  bool isVisible = true;

  // functions
  @override
  void initState() {
    super.initState();
  }

  void submit() {
    bool isValid = _loginFormKey.currentState!.validate();
    if (!isValid) return;
    _loginFormKey.currentState!.save();

    context.read<AuthenticationBloc>().add(LoginEvent(
          username: loginData['phone'],
          password: loginData['password'],
        ));
    Navigator.of(context).pop();
  }

  void showPassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("login screen");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kirish',
                    style: GoogleFonts.nunito(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "99 123 45 67",
                          ),
                          inputFormatters: [
                            MaskedInputFormatter(
                              '## ### ## ##',
                            )
                          ],
                          onSaved: (value) {
                            setState(() {
                              loginData['phone'] = value!.replaceAll(' ', '');
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Iltimos telefon raqam kiriting!';
                            } else if (value.length < 9) {
                              return 'Telefon raqam mos kelmadi!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            TextFormField(
                              obscureText: isVisible,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Parol",
                              ),
                              onSaved: (value) {
                                setState(() {
                                  loginData['password'] = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Iltimos parol kiriting!';
                                }
                                return null;
                              },
                            ),
                            Positioned(
                              top: 5,
                              right: 0,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                splashRadius: 2,
                                onPressed: showPassword,
                                icon: Icon(
                                  isVisible ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: Ink(
                width: 150,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () => submit(),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Kirish'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mPlus1(color: Colors.white, fontSize: 27),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
