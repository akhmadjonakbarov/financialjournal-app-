part of 'month_report_bloc.dart';

class MonthReportEvent extends Equatable {
  const MonthReportEvent();

  @override
  List<Object> get props => [];
}

class GetMonthReportEvent extends MonthReportEvent {
  final int monthNumber;
  const GetMonthReportEvent({
    required this.monthNumber,
  });
}
