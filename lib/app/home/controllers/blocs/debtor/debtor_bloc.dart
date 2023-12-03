import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../../utils/connectivity_service.dart';
import '../../../models/debtor_model.dart';
import '../../repositories/debtor_repository.dart';
import '../../services/debtor_service.dart';

part 'debtor_event.dart';

part 'debtor_state.dart';

class DebtorBloc extends Bloc<DebtorEvent, DebtorState> {
  GetDebtorRepository getDebtorRepository = GetDebtorRepository(
    GetDebtorService(),
  );

  DebtorBloc() : super(DebtorState()) {
    on<DebtorGetEvent>(_getDebtor);
    on<DebtorAddEvent>(_addDebtor);
    on<DebtorUpdateEvent>(_updateDebtor);
    on<DebtorDeleteEvent>(_deleteDebtor);
  }

  final ConnectivityService _connectivityService = ConnectivityService();
  final _connectionController = StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _connectionController.stream;

  _getDebtor(DebtorGetEvent event, Emitter<DebtorState> emit) async {
    List<DebtorModel> debtors = [];
    bool isHasInternet = await _connectivityService.checkConnection();
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      debtors = await getDebtorRepository.getDebtor() as List<DebtorModel>;
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        debtors: debtors,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: FormzSubmissionStatus.failure,
      ));
    }
  }

  _addDebtor(DebtorAddEvent event, Emitter<DebtorState> emit) async {
    AddDebtorRepository addDebtorRepository = AddDebtorRepository(
      AddDebtorService(),
    );
    List<DebtorModel> debtors = [];

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await addDebtorRepository.addDebtor(
        name: event.name,
        phone: event.phone,
        status: 1,
      );
      debtors = await getDebtorRepository.getDebtor();
      emit(state.copyWith(
          debtors: debtors, status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: FormzSubmissionStatus.failure,
      ));
    }
  }

  _updateDebtor(DebtorUpdateEvent event, Emitter<DebtorState> emit) async {
    UpdateDebtorRepository updateDebtorRepository = UpdateDebtorRepository(
      UpdateDebtorService(),
    );
    List<DebtorModel> debtors = [];
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await updateDebtorRepository.updateDebtor(
        debtorId: event.id,
        newName: event.newName,
        newPhone: event.newPhone,
      );
      debtors = await getDebtorRepository.getDebtor() as List<DebtorModel>;
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        debtors: debtors,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: FormzSubmissionStatus.failure,
      ));
    }
  }

  _deleteDebtor(DebtorDeleteEvent event, Emitter<DebtorState> emit) async {
    DeleteDebtorRepository debtorRepository = DeleteDebtorRepository(
      DeleteDebtorService(),
    );
    List<DebtorModel> debtors = [];
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await debtorRepository.deleteDebtor(debtorId: event.id);
      debtors = await getDebtorRepository.getDebtor() as List<DebtorModel>;
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        debtors: debtors,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        status: FormzSubmissionStatus.failure,
      ));
    }
  }
}
