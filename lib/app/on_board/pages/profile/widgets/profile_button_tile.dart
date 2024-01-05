// ignore_for_file: must_be_immutable

import 'package:financialjournal_app/contants/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileButtonTile extends StatelessWidget {
  final String title;
  final IconData icon;
  Function()? onTap;
  ProfileButtonTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 50,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.BORDERRADIUS),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(
                      icon,
                      size: 25,
                      color: const Color(0xFF767E8C),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.right_chevron)
          ],
        ),
      ),
    );
  }
}
