import '../services/total_amount_services.dart';

abstract class TotalAmountRepository {
  Future getIncomeTotalAmount({required debtorId});
  Future getOutlayTotalAmount({required debtorId});
}

class GetIncomeTotalAmountRepository extends TotalAmountRepository {
  final GetIncomeTotalAmountService _getIncomeTotalAmountService;
  GetIncomeTotalAmountRepository(this._getIncomeTotalAmountService);
  @override
  Future getIncomeTotalAmount({required debtorId}) async {
    return await _getIncomeTotalAmountService.getIncomeTotalAmount(
      debtorId: debtorId,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class GetOutlayTotalAmountRepository extends TotalAmountRepository {
  final GetOutlayTotalAmountService _getOutlayTotalAmountService;
  GetOutlayTotalAmountRepository(this._getOutlayTotalAmountService);
  @override
  Future getOutlayTotalAmount({required debtorId}) async {
    return await _getOutlayTotalAmountService.getOutlayTotalAmount(
      debtorId: debtorId,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
