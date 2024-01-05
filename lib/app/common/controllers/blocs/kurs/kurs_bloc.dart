import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repositories/kurs_repository.dart';
import '../../services/kurs_service.dart';
import '../../../models/kurs_model.dart';
import 'package:formz/formz.dart';

part 'kurs_event.dart';

part 'kurs_state.dart';

class KursBloc extends Bloc<KursEvent, KursState> {
  final GetKurssRepository getKurssRepository = GetKurssRepository(
    GetKursService(),
  );

  KursBloc() : super(const KursState()) {
    on<KurssGetEvent>(_getKurss);
    // on<SingleKursGetEvent>(_getSingleKurs);
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
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<KursModel> getSingleKurs() async {
    KursModel kurs;

    try {
      kurs = await getKurssRepository.getSingleKurs();
      return kurs;
    } catch (e) {
      rethrow;
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
