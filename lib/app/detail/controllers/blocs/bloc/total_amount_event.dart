// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'total_amount_bloc.dart';

class TotalAmountEvent extends Equatable {
  const TotalAmountEvent();

  @override
  List<Object> get props => [];
}

class GetTotalAmountEvent extends TotalAmountEvent {
  final int debtorId;
  const GetTotalAmountEvent({
    required this.debtorId,
  });
}
