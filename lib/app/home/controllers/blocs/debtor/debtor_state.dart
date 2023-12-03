// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'debtor_bloc.dart';

class DebtorState extends Equatable {
  final FormzSubmissionStatus status;
  final List<DebtorModel> debtors;
  final String errorMessage;

  DebtorState({
    this.status = FormzSubmissionStatus.initial,
    this.debtors = const [],
    this.errorMessage = '',
  });

  @override
  List<Object> get props => [status, debtors, errorMessage];

  DebtorState copyWith({
    FormzSubmissionStatus? status,
    List<DebtorModel>? debtors,
    String? errorMessage,
  }) {
    return DebtorState(
      status: status ?? this.status,
      debtors: debtors ?? this.debtors,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}


