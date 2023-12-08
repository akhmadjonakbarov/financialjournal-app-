class IncomeModel {
  int id;
  int debtorId;
  double money;
  int status;
  DateTime dateTime;
  String expressionHistory;
  int currencyConvert;
  int currencyId;

  IncomeModel({
    required this.id,
    required this.debtorId,
    required this.currencyId,
    required this.money,
    required this.expressionHistory,
    required this.status,
    required this.currencyConvert,
    required this.dateTime,
  });
}
