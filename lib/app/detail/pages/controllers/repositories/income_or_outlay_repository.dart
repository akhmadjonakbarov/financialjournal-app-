import 'package:financialjournal_app/app/detail/pages/controllers/services/income_or_outlay_service.dart';

abstract class Incomeoroutlayrepository {
  Future getIncomeOrOutlay({required int debtorId, required bool isIncome});
}

class GetIncomeOrOutlayRepository extends Incomeoroutlayrepository {
  GetIncomeOrOutlayService _getIncomeOrOutlayService;

  GetIncomeOrOutlayRepository(this._getIncomeOrOutlayService);

  @override
  Future getIncomeOrOutlay(
      {required int debtorId, required bool isIncome}) async {
    return await _getIncomeOrOutlayService.getIncomeOrOutlay(
      debtorId: debtorId,
      isIncome: isIncome,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
