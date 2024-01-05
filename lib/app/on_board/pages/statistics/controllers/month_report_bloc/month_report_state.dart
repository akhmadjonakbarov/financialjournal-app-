part of 'month_report_bloc.dart';

class MonthReportState extends Equatable {
  final FormzSubmissionStatus status;
  final double account;
  final double monthIncome;
  final double monthOutlay;
  final String errorMessage;

  const MonthReportState({
    this.status = FormzSubmissionStatus.initial,
    this.account = 0,
    this.monthIncome = 0,
    this.monthOutlay = 0,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [status, account, errorMessage];

  MonthReportState copyWith({
    FormzSubmissionStatus? status,
    double? account,
    double? monthIncome,
    double? monthOutlay,
    String? errorMessage,
  }) {
    return MonthReportState(
      status: status ?? this.status,
      account: account ?? this.account,
      monthIncome: monthIncome ?? this.monthIncome,
      monthOutlay: monthOutlay ?? this.monthOutlay,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
