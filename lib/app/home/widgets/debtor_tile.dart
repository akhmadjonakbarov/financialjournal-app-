import 'package:financialjournal_app/app/detail/detial_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DebtorTile extends StatelessWidget {
  const DebtorTile({super.key});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rostan ham User o\'chirishni istaysizmi?',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Ink(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.error,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).pop(),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Ha',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Ink(
                  width: 80,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.green,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.of(context).pop(),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Yo\'q',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => const DetailScreen(),
        ));
      },
      title: Text(
        'Name',
        style: GoogleFonts.nunito(fontSize: 18),
      ),
      subtitle: Text(
        'phonumber',
        style: GoogleFonts.nunito(fontSize: 17),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Ink(
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () => print("SEARCH"),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  CupertinoIcons.pencil,
                  size: 25,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Ink(
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () => _showDeleteDialog(context),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  CupertinoIcons.delete_simple,
                  size: 25,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
