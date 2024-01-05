part of 'total_amount_bloc.dart';

class TotalAmountState extends Equatable {
  final FormzSubmissionStatus status;
  final double account;
  final String errorMessage;
  const TotalAmountState({
    this.status = FormzSubmissionStatus.initial,
    this.account = 0,
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [status, account, errorMessage];

  TotalAmountState copyWith({
    FormzSubmissionStatus? status,
    double? account,
    String? errorMessage,
  }) {
    return TotalAmountState(
      status: status ?? this.status,
      account: account ?? this.account,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
