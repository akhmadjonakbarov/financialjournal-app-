part of 'kurs_bloc.dart';

class KursState extends Equatable {
  FormzSubmissionStatus status;
  List<KursModel> kurss;
  KursModel? kurs;
  String errorMessage;
  KursState({
    this.status = FormzSubmissionStatus.initial,
    this.kurss = const [],
    this.errorMessage = '',
    this.kurs,
  });

  KursState copyWith({
    FormzSubmissionStatus? status,
    List<KursModel>? kurss,
    KursModel? kurs,
    String? errorMessage,
  }) {
    return KursState(
      status: status ?? this.status,
      kurss: kurss ?? this.kurss,
      kurs: kurs ?? this.kurs,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, kurss, errorMessage];
}
