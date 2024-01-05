import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/kurs/kurs_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Kurs \$',
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const KursScreen(),
                ),
              ),
              trailing: const Icon(CupertinoIcons.arrow_right),
            )
          ],
        ),
      ),
    );
  }
}
