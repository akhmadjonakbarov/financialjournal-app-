part of 'debtor_bloc.dart';

sealed class DebtorEvent extends Equatable {
  const DebtorEvent();

  @override
  List<Object> get props => [];
}

class DebtorGetEvent extends DebtorEvent {}

class DebtorAddEvent extends DebtorEvent {
  final String name;
  final String phone;

  const DebtorAddEvent({required this.name, required this.phone});
}

class DebtorUpdateEvent extends DebtorEvent {
  final String newName;
  final String newPhone;
  final int id;

  const DebtorUpdateEvent({
    required this.newName,
    required this.newPhone,
    required this.id,
  });
}

class DebtorDeleteEvent extends DebtorEvent {
  final int id;

  const DebtorDeleteEvent({required this.id});
}
