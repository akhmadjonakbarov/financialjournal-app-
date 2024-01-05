import 'package:dio/dio.dart';
import 'package:financialjournal_app/app/detail/models/totalamount_model.dart';
import '../../../../../../utils/dio/dio_settings.dart';
import '../../../../../../utils/generate_auth.dart';
import '../../../../../../utils/service_locator.dart/service_locator.dart';

abstract class MonthReportService {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  Map<String, dynamic> _auth = {
    'Authorization': '',
  };
  Future getMonthIncomeReport({required int monthNumber});
  Future getMonthOutlayReport({required int monthNumber});
}

class GetMonthIncomeReportService extends MonthReportService {
  @override
  Future getMonthIncomeReport({required int monthNumber}) async {
    TotalAmountModel incomeReport = TotalAmountModel(
      amountType: 0,
      totalAmount: 0.0,
    );
    const monthIncomeReportURL = "/api/statistic";
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();

    try {
      if (_auth.isNotEmpty) {
        Response response = await _dio.get(
          "$monthIncomeReportURL/$monthNumber/",
          options: Options(
            headers: _auth,
          ),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> resData = response.data as Map<String, dynamic>;
          if (resData['data'] != null) {
            for (var element in resData['data']) {
              if (element['status'] == "0") {
                incomeReport = TotalAmountModel(
                  amountType: int.parse(element['status']),
                  totalAmount: element['total_amount'] != 0
                      ? int.parse(element['total_amount'].toString()).toDouble()
                      : 0.0,
                );
              }
            }
          }
        }
        return incomeReport;
      }
    } on DioException {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class GetMonthOutlayReportService extends MonthReportService {
  @override
  Future getMonthOutlayReport({required int monthNumber}) async {
    TotalAmountModel incomeReport = TotalAmountModel(
      amountType: 1,
      totalAmount: 0.0,
    );
    const monthOutlayReportURL = "/api/statistic";
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();
    try {
      if (_auth.isNotEmpty) {
        Response response = await _dio.get(
          "$monthOutlayReportURL/$monthNumber/",
          options: Options(
            headers: _auth,
          ),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> resData = response.data as Map<String, dynamic>;
          if (resData['data'] != null) {
            for (var element in resData['data']) {
              if (element['status'] == "1") {
                incomeReport = TotalAmountModel(
                  amountType: int.parse(element['status']),
                  totalAmount: element['total_amount'] != 0
                      ? int.parse(element['total_amount'].toString()).toDouble()
                      : 0.0,
                );
              }
            }
          }
        }
        return incomeReport;
      }
    } on DioException {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
