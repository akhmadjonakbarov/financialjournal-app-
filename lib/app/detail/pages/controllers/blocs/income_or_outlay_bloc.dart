import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:financialjournal_app/app/detail/pages/controllers/repositories/income_or_outlay_repository.dart';
import 'package:financialjournal_app/app/detail/pages/controllers/services/income_or_outlay_service.dart';

import 'package:financialjournal_app/app/detail/pages/models/income_model.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'income_or_outlay_event.dart';

part 'income_or_outlay_state.dart';

class IncomeOrOutlayBloc extends Bloc<IncomeOrOutlayEvent, IncomeOrOutlayState> {
  GetIncomeOrOutlayRepository getIncomeOrOutlayRepository = GetIncomeOrOutlayRepository(
    GetIncomeOrOutlayService(),
  );

  IncomeOrOutlayBloc() : super(IncomeOrOutlayState()) {
    on<IncomeGetEvent>(_getIncomes);
    on<OutlayGetEvent>(_getOutlays);
    on<IncomeAddEvent>(_addIncome);

    state.dataStreamController.add(state.incomes);
    state.dataStreamController.add(state.outlays);
  }

  _getIncomes(IncomeGetEvent event, Emitter<IncomeOrOutlayState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    List<IncomeModel> incomes = [];
    try {
      incomes = await getIncomeOrOutlayRepository.getIncomeOrOutlay(
        debtorId: event.debtorId,
        isIncome: true,
      );
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        incomes: incomes,
      ));
      state.dataStreamController.add(incomes);
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  _getOutlays(OutlayGetEvent event, Emitter<IncomeOrOutlayState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    List<IncomeModel> outlays = [];
    try {
      outlays = await getIncomeOrOutlayRepository.getIncomeOrOutlay(
        debtorId: event.debtorId,
        isIncome: false,
      );
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        outlays: outlays,
      ));
      state.dataStreamController.add(outlays);
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  _addIncome(IncomeAddEvent event, Emitter<IncomeOrOutlayState> emit) async {
    AddIncomeOrOutlayRepository addIncomeOrOutlayRepository = AddIncomeOrOutlayRepository(
      AddIncomeOrOutlayService(),
    );
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    List<IncomeModel> incomes = [];
    try {
      await addIncomeOrOutlayRepository.addIncomeOrOutlay(
        debtorId: event.debtorId,
        currencyId: event.currencyId,
        currencyConvert: event.currencyConvert,
        expressionHistory: event.expressionHistory,
        money: event.money,
        status: event.status,
        dateTime: event.dateTime,
      );
      incomes = await getIncomeOrOutlayRepository.getIncomeOrOutlay(
        debtorId: event.debtorId,
        isIncome: true,
      );
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        incomes: incomes,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    state.dataStreamController.close();
    return super.close();
  }
}
