import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const AuthButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
