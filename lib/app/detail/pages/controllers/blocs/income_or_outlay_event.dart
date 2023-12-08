part of 'income_or_outlay_bloc.dart';

@immutable
abstract class IncomeOrOutlayEvent {}

class IncomeGetEvent extends IncomeOrOutlayEvent {
  final int debtorId;

  IncomeGetEvent({required this.debtorId});
}

class OutlayGetEvent extends IncomeOrOutlayEvent {
  final int debtorId;

  OutlayGetEvent({required this.debtorId});
}

class IncomeAddEvent extends IncomeOrOutlayBloc {
  final int debtorId;
  final int currencyId;
  final int currencyConvert;
  final String expressionHistory;
  final double money;
  int status;
  final DateTime dateTime;

  IncomeAddEvent({
    required this.debtorId,
    required this.currencyId,
    required this.currencyConvert,
    required this.expressionHistory,
    required this.money,
    this.status = 0,
    required this.dateTime,
  });
}

class OutlayAddEvent extends IncomeOrOutlayBloc {
  final int debtorId;
  final int currencyId;
  final int currencyConvert;
  final String expressionHistory;
  final double money;
  int status;
  final DateTime dateTime;

  OutlayAddEvent({
    required this.debtorId,
    required this.currencyId,
    required this.currencyConvert,
    required this.expressionHistory,
    required this.money,
    this.status = 1,
    required this.dateTime,
  });
}
