import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveButton extends StatefulWidget {
  final Function()? onTap;
  final bool isUpdate;
  const SaveButton({super.key, required this.onTap, this.isUpdate = false});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Ink(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: widget.onTap,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.isUpdate ? 'Yangilash' : 'Saqlash',
              style: GoogleFonts.nunito(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
