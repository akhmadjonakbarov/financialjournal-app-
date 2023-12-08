import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Implement your custom formatting logic here
    // Example: Format the text as a number with commas
    String formattedText = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove non-digits
    final number = int.tryParse(formattedText) ?? 0;
    final formattedValue = NumberFormat('##,##0').format(number);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
