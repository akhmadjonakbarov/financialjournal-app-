import 'package:intl/intl.dart';

class MoneyFormatter {
  final oCcy = NumberFormat("#,##0");
  String formatter({required double data}) {
    return oCcy.format(data);
  }
}
