import '../services/income_or_outlay_service.dart';

abstract class IncomeOrOutlayRepository {
  Future getIncomeOrOutlay({required int debtorId, required bool isIncome});
  Future addIncomeOrOutlay({
    required int debtorId,
    required int currencyId,
    required int currencyConvert,
    required String expressionHistory,
    required double money,
    required int status,
    required DateTime dateTime,
  });
  Future updateIncomeOrOutlay({
    required int id,
    required int debtorId,
    required int currencyId,
    required int currencyConvert,
    required String expressionHistory,
    required double money,
    required int status,
    required DateTime dateTime,
  });
  Future deleteIncomeOrOutlay({required int id});
}

class GetIncomeOrOutlayRepository extends IncomeOrOutlayRepository {
  final GetIncomeOrOutlayService _getIncomeOrOutlayService;

  GetIncomeOrOutlayRepository(this._getIncomeOrOutlayService);

  @override
  Future getIncomeOrOutlay({required int debtorId, required bool isIncome}) async {
    return await _getIncomeOrOutlayService.getIncomeOrOutlay(
      debtorId: debtorId,
      isIncome: isIncome,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class AddIncomeOrOutlayRepository extends IncomeOrOutlayRepository {
  final AddIncomeOrOutlayService _addIncomeOrOutlayService;
  AddIncomeOrOutlayRepository(this._addIncomeOrOutlayService);

  @override
  Future addIncomeOrOutlay(
      {required int debtorId,
      required int currencyId,
      required int currencyConvert,
      required String expressionHistory,
      required double money,
      required int status,
      required DateTime dateTime}) async {
    await _addIncomeOrOutlayService.addIncomeOrOutlay(
      debtorId: debtorId,
      currencyId: currencyId,
      currencyConvert: currencyConvert,
      expressionHistory: expressionHistory,
      money: money,
      status: status,
      dateTime: dateTime,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UpdateIncomeOrOutlayRepository extends IncomeOrOutlayRepository {
  final UpdateIncomeOrOutlayService _updateIncomeOrOutlayService;
  UpdateIncomeOrOutlayRepository(this._updateIncomeOrOutlayService);
  @override
  Future updateIncomeOrOutlay(
      {required int id,
      required int debtorId,
      required int currencyId,
      required int currencyConvert,
      required String expressionHistory,
      required double money,
      required int status,
      required DateTime dateTime}) async {
    await _updateIncomeOrOutlayService.updateIncomeOrOutlay(
      id: id,
      debtorId: debtorId,
      currencyId: currencyId,
      currencyConvert: currencyConvert,
      expressionHistory: expressionHistory,
      money: money,
      status: status,
      dateTime: dateTime,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DeleteIncomeOrOutlayRepository extends IncomeOrOutlayRepository {
  final DeleteIncomeOrOutlayService _deleteIncomeOrOutlayService;
  DeleteIncomeOrOutlayRepository(this._deleteIncomeOrOutlayService);

  @override
  Future deleteIncomeOrOutlay({required int id}) async {
    await _deleteIncomeOrOutlayService.deleteIncomeOrOutlay(id: id);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
