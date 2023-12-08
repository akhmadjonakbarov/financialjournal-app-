import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financialjournal_app/app/common/controllers/repositories/kurs_repository.dart';
import 'package:financialjournal_app/app/common/controllers/services/kurs_service.dart';
import 'package:financialjournal_app/app/common/models/kurs_model.dart';
import 'package:formz/formz.dart';

part 'kurs_event.dart';

part 'kurs_state.dart';

class KursBloc extends Bloc<KursEvent, KursState> {
  final GetKurssRepository getKurssRepository = GetKurssRepository(
    GetKursService(),
  );

  KursBloc() : super(KursState()) {
    on<KurssGetEvent>(_getKurss);
    on<SingleKursGetEvent>(_getSingleKurs);
    on<KursAddEvent>(_addKurs);
  }

  void _getKurss(KurssGetEvent event, Emitter<KursState> emit) async {
    List<KursModel> kurss = [];
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      kurss = await getKurssRepository.getKurss();
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        kurss: kurss,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _getSingleKurs(SingleKursGetEvent event, Emitter<KursState> emit) async {
    KursModel kurs;
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      kurs = await getKurssRepository.getSingleKurs();
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        kurs: kurs,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _addKurs(KursAddEvent event, Emitter<KursState> emit) async {
    AddKursRepository addKursRepository = AddKursRepository(
      AddKursService(),
    );
    List<KursModel> kurss = [];
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await addKursRepository.addKurs(kurs: event.kurs);
      emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress,
      ));
      kurss = await getKurssRepository.getKurss();
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        kurss: kurss,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
