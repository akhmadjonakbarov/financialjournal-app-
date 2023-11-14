import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  Map<String, dynamic> registerData = {
    'name': '',
    'username': '',
    'password': '',
    'confirm_password': '',
  };

  bool isVisible = true;

  // functions
  void submit() {
    bool isValid = _registerFormKey.currentState!.validate();
    if (!isValid) return;
    _registerFormKey.currentState!.save();

    // login bloc
  }

  void showPassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    'Ro\'yhatdan o\'tish',
                    style: GoogleFonts.nunito(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Ism",
                          ),
                          onSaved: (value) {
                            setState(() {
                              registerData['name'] = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Iltimos ism kiriting!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
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
                              registerData['username'] = value!.replaceAll(' ', '');
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
                                  registerData['password'] = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  registerData['password'] = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Iltimos parol kiriting!';
                                } else if (value.length <= 6) {
                                  return 'Parol 6 belgidan ko\'proq bo\'lishi shart!';
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
                                hintText: "Parolni tasdiqlash",
                              ),
                              onSaved: (value) {
                                setState(() {
                                  registerData['confirm_password'] = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  registerData['confirm_password'] = value;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Iltimos parol kiriting!';
                                } else if (value.length <= 6) {
                                  return 'Parol 6 belgidan ko\'proq bo\'lishi shart!';
                                }
                                return null;
                              },
                            ),
                            // Positioned(
                            //   top: 5,
                            //   right: 0,
                            //   child: IconButton(
                            //     padding: EdgeInsets.zero,
                            //     splashRadius: 2,
                            //     onPressed: showPassword,
                            //     icon: Icon(
                            //       isVisible ? Icons.visibility : Icons.visibility_off,
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (registerData['confirm_password'] != registerData['password'])
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Parol mos emas!',
                    style: GoogleFonts.nunito(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Ink(
                width: double.infinity,
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
                      'Ro\'yhatdan o\'tish'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mPlus1(color: Colors.white, fontSize: 25),
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
