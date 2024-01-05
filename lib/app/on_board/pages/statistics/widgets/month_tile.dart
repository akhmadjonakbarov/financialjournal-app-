import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthTile extends StatelessWidget {
  final String title;
  final int index;
  final Function(int) onTap;
  final bool isSelected;
  const MonthTile({
    super.key,
    required this.title,
    required this.index,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: GoogleFonts.nunito(
          fontSize: 20,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Get the width and height of the text
    double textWidth = textPainter.width;
    double textHeight = textPainter.height;

    // Set the size of the container based on the text length
    double containerWidth = textWidth + 16.0; // Add some padding
    double containerHeight = textHeight + 16.0; // Add some padding

    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Container(
        alignment: Alignment.center,
        width: containerWidth,
        height: containerHeight,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : null,
          border: Border.all(),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: GoogleFonts.nunito(
            fontSize: 18,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
