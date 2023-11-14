import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    super.key,
    required this.time,
  });

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Ink(
                child: InkWell(
                  onTap: () => print('PROFILE'),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '$time User!',
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
