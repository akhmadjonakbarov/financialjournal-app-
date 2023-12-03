import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../contants/app_sizes.dart';
import '../../authentication/models/user_model.dart';

class ProfileAppBar extends StatelessWidget {
  Function()? onTap;

  ProfileAppBar({
    super.key,
    required this.time,
    required this.user,
    this.onTap,
  });

  final UserModel user;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: AppSizes.HEIGHT60,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Ink(
                child: InkWell(
                  onTap: () {
                    onTap!();
                  },
                  child: Icon(
                    CupertinoIcons.line_horizontal_3,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                '$time ${user.name}!',
                style: GoogleFonts.lato(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Ink(
              child: InkWell(
                onTap: () => print("SEARCH"),
                child: const Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
