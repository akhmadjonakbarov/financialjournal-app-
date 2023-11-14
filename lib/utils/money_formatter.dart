import 'package:intl/intl.dart';

class MoneyFormatter {
  final _numberFormat = NumberFormat("#,##0");
  String formatter({required double data}) {
    return _numberFormat.format(data);
  }
}
