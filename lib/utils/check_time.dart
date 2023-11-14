String checkTime() {
  String time = '';
  DateTime dateTimeNow = DateTime.now();
  if (dateTimeNow.hour >= 6 && dateTimeNow.hour < 10) {
    time = 'Hayrli tong';
  } else if (dateTimeNow.hour >= 10 && dateTimeNow.hour < 16) {
    time = 'Hayrli kun';
  } else {
    time = 'Hayrli kech';
  }
  return time;
}
