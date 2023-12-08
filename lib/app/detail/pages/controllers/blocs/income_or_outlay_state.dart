part of 'income_or_outlay_bloc.dart';

@immutable
class IncomeOrOutlayState {
  final FormzSubmissionStatus status;
  final List<IncomeModel> incomes;
  final List<IncomeModel> outlays;
  final String errorMessage;
  final StreamController<List<IncomeModel>> dataStreamController;

  IncomeOrOutlayState({
    this.status = FormzSubmissionStatus.initial,
    this.incomes = const [],
    this.outlays = const [],
    this.errorMessage = '',
  }) : dataStreamController = StreamController<List<IncomeModel>>.broadcast();

  IncomeOrOutlayState copyWith({
    FormzSubmissionStatus? status,
    List<IncomeModel>? incomes,
    List<IncomeModel>? outlays,
    String? errorMessage,
  }) {
    return IncomeOrOutlayState(
      status: status ?? this.status,
      incomes: incomes ?? this.incomes,
      outlays: outlays ?? this.outlays,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
