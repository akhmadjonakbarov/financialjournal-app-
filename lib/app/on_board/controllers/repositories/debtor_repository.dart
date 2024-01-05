import '../services/debtor_service.dart';

abstract class DebtorRepository {
  Future getDebtor();
  Future addDebtor({
    required String name,
    required String phone,
    required int status,
  });
  Future updateDebtor({
    required int debtorId,
    required String newName,
    required String newPhone,
  });
  Future deleteDebtor({required int debtorId});
}

class GetDebtorRepository extends DebtorRepository {
  final GetDebtorService _debtorService;
  GetDebtorRepository(this._debtorService);

  @override
  Future getDebtor() async {
    return await _debtorService.getDebtor();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class AddDebtorRepository extends DebtorRepository {
  final AddDebtorService _addDebtorService;
  AddDebtorRepository(this._addDebtorService);

  @override
  Future addDebtor({required String name, required String phone, required int status}) async {
    await _addDebtorService.addDebtor(
      name: name,
      phone: phone,
      status: status,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UpdateDebtorRepository extends DebtorRepository {
  final UpdateDebtorService _updateDebtorService;
  UpdateDebtorRepository(this._updateDebtorService);
  @override
  Future updateDebtor({
    required int debtorId,
    required String newName,
    required String newPhone,
  }) async {
    await _updateDebtorService.updateDebtor(
      debtorId: debtorId,
      newName: newName,
      newPhone: newPhone,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DeleteDebtorRepository extends DebtorRepository {
  final DeleteDebtorService _deleteDebtorService;
  DeleteDebtorRepository(this._deleteDebtorService);
  @override
  Future deleteDebtor({required int debtorId}) async {
    _deleteDebtorService.deleteDebtor(debtorId: debtorId);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
