part of 'kurs_bloc.dart';

class KursEvent extends Equatable {
  const KursEvent();

  @override
  List<Object> get props => [];
}

class KurssGetEvent extends KursEvent {}

class SingleKursGetEvent extends KursEvent {}

class KursAddEvent extends KursEvent {
  final double kurs;

  const KursAddEvent({
    required this.kurs,
  });
}

class KursDeleteEvent extends KursEvent {
  final int kursId;

  const KursDeleteEvent({required this.kursId});
}
