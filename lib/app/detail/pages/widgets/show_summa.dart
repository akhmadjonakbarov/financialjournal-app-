import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowSumma extends StatelessWidget {
  const ShowSumma({
    super.key,
    required this.expressionSum,
    required this.isUZS,
    required this.label,
  });
  final String label;
  final String expressionSum;
  final bool isUZS;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label miqdori:',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(
            '$expressionSum ${isUZS ? 'UZS' : "\$"}',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
