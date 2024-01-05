// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import '../repositories/income_or_outlay_repository.dart';
import '../services/income_or_outlay_service.dart';

import '../../models/income_model.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'income_or_outlay_event.dart';

part 'income_or_outlay_state.dart';

class IncomeOrOutlayBloc
    extends Bloc<IncomeOrOutlayEvent, IncomeOrOutlayState> {
  GetIncomeOrOutlayRepository getIncomeOrOutlayRepository =
      GetIncomeOrOutlayRepository(
    GetIncomeOrOutlayService(),
  );

  IncomeOrOutlayBloc() : super(IncomeOrOutlayState()) {
    on<IncomeGetEvent>(_getIncomes);
    on<OutlayGetEvent>(_getOutlays);
    on<IncomeAddEvent>(_addIncome);
    on<OutlayAddEvent>(_addOutlay);
    on<IncomeOrOutlayUpdateEvent>(_updateIncomeOrOutlay);
    on<DeleteIcomeOrOutlayEvent>(_deleteIncomeOrOutlay);
  }

  _getIncomes(IncomeGetEvent event, Emitter<IncomeOrOutlayState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    List<IncomeModel> incomes = [];
    double summa = 0.0;
    try {
      incomes = await getIncomeOrOutlayRepository.getIncomeOrOutlay(
        debtorId: event.debtorId,
        isIncome: true,
      );

      for (var element in incomes) {
        summa = summa + element.money;
      }

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        incomes: incomes,
        summaK: summa,
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
    double summa = 0.0;
    try {
      outlays = await getIncomeOrOutlayRepository.getIncomeOrOutlay(
        debtorId: event.debtorId,
        isIncome: false,
      );
      for (var element in outlays) {
        summa = summa + element.money;
      }

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        outlays: outlays,
        summaCh: summa,
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
    AddIncomeOrOutlayRepository addIncomeOrOutlayRepository =
        AddIncomeOrOutlayRepository(
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

  _updateIncomeOrOutlay(IncomeOrOutlayUpdateEvent event,
      Emitter<IncomeOrOutlayState> emit) async {
    UpdateIncomeOrOutlayRepository updateIncomeOrOutlayRepository =
        UpdateIncomeOrOutlayRepository(
      UpdateIncomeOrOutlayService(),
    );
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await updateIncomeOrOutlayRepository.updateIncomeOrOutlay(
        id: event.id,
        debtorId: event.debtorId,
        currencyId: event.currencyId,
        currencyConvert: event.currencyConvert,
        expressionHistory: event.expressionHistory,
        money: event.money,
        status: event.status,
        dateTime: event.dateTime,
      );
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  _addOutlay(OutlayAddEvent event, Emitter<IncomeOrOutlayState> emit) async {
    AddIncomeOrOutlayRepository addIncomeOrOutlayRepository =
        AddIncomeOrOutlayRepository(
      AddIncomeOrOutlayService(),
    );
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    List<IncomeModel> outlays = [];
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
      outlays = await getIncomeOrOutlayRepository.getIncomeOrOutlay(
        debtorId: event.debtorId,
        isIncome: false,
      );
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        incomes: outlays,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  _deleteIncomeOrOutlay(
      DeleteIcomeOrOutlayEvent event, Emitter<IncomeOrOutlayState> emit) async {
    DeleteIncomeOrOutlayRepository deleteIncomeOrOutlayRepository =
        DeleteIncomeOrOutlayRepository(
      DeleteIncomeOrOutlayService(),
    );
    List<IncomeModel> outlays = [];
    List<IncomeModel> incomes = [];
    double summaK = 0.0;
    double summaCh = 0.0;
    try {
      await deleteIncomeOrOutlayRepository.deleteIncomeOrOutlay(
        id: event.id,
      );
      outlays = await getIncomeOrOutlayRepository.getIncomeOrOutlay(
        debtorId: event.debtorId,
        isIncome: false,
      );
      incomes = await getIncomeOrOutlayRepository.getIncomeOrOutlay(
        debtorId: event.debtorId,
        isIncome: true,
      );
      for (var element in outlays) {
        summaCh = summaCh + element.money;
      }

      for (var element in incomes) {
        summaK = summaK + element.money;
      }

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        incomes: incomes,
        summaK: summaK,
      ));

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        outlays: outlays,
        summaCh: summaCh,
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
