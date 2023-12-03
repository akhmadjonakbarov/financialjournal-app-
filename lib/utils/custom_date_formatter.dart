import 'package:intl/intl.dart';

String dateFormatter(DateTime dateTime) {
  return DateFormat("dd-MM-y").format(dateTime.toLocal());
}
