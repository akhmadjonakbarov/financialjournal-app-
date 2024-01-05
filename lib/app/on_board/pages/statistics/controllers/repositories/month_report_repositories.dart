import 'package:financialjournal_app/app/on_board/pages/statistics/controllers/services/month_report_services.dart';

abstract class MonthReportRepository {
  Future getMonthIncomeReport({required int monthNumber});
  Future getMonthOutlayReport({required int monthNumber});
}

class GetMonthIncomeReportRepository extends MonthReportRepository {
  final GetMonthIncomeReportService _getMonthIncomeReportService;
  GetMonthIncomeReportRepository(this._getMonthIncomeReportService);
  @override
  Future getMonthIncomeReport({required int monthNumber}) async {
    return await _getMonthIncomeReportService.getMonthIncomeReport(
      monthNumber: monthNumber,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class GetMonthOutlayRepository extends MonthReportRepository {
  final GetMonthOutlayReportService _getMonthOutlayReportService;
  GetMonthOutlayRepository(this._getMonthOutlayReportService);
  @override
  Future getMonthOutlayReport({required int monthNumber}) async {
    return await _getMonthOutlayReportService.getMonthOutlayReport(
      monthNumber: monthNumber,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
