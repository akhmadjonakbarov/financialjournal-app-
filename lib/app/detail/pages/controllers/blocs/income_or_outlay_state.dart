// ignore_for_file: must_be_immutable

part of 'income_or_outlay_bloc.dart';

@immutable
class IncomeOrOutlayState {
  final FormzSubmissionStatus status;
  final List<IncomeModel> incomes;
  final List<IncomeModel> outlays;
  final String errorMessage;
  final StreamController<List<IncomeModel>> dataStreamController;
  double summaK;
  double summaCh;

  IncomeOrOutlayState({
    this.status = FormzSubmissionStatus.initial,
    this.incomes = const [],
    this.summaK = 0.0,
    this.outlays = const [],
    this.summaCh = 0.0,
    this.errorMessage = '',
  }) : dataStreamController = StreamController<List<IncomeModel>>.broadcast();

  IncomeOrOutlayState copyWith({
    FormzSubmissionStatus? status,
    List<IncomeModel>? incomes,
    double? summaK,
    List<IncomeModel>? outlays,
    double? summaCh,
    String? errorMessage,
  }) {
    return IncomeOrOutlayState(
      status: status ?? this.status,
      incomes: incomes ?? this.incomes,
      summaK: summaK ?? this.summaK,
      outlays: outlays ?? this.outlays,
      summaCh: summaCh ?? this.summaCh,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UpdateIncomeOrOutlayState extends IncomeOrOutlayState {}

class IncomeIncomeOrOutlayState extends IncomeOrOutlayState {}
