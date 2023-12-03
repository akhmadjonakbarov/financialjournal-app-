import 'package:financialjournal_app/app/home/models/debtor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  bool isBackButton;
  final String text;


  CustomAppBar({
    super.key,
    this.isBackButton = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: isBackButton,
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Text(
        text,
        style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
      ),
    );
    // return Container(
    //   alignment: Alignment.center,
    //   width: double.infinity,
    //   padding: const EdgeInsets.symmetric(
    //     horizontal: 15,
    //   ),
    //   margin: const EdgeInsets.symmetric(horizontal: 3),
    //   height: 60,
    //   decoration: const BoxDecoration(
    //     color: Colors.black,
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(16),
    //       bottomRight: Radius.circular(16),
    //     ),
    //   ),
    //   child: Text(
    //     debtor.name,
    //     style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
    //   ),
    // );
  }
}
