import 'package:dio/dio.dart';
import 'package:financialjournal_app/app/detail/models/totalamount_model.dart';
import '../../../../utils/generate_auth.dart';

import '../../../../utils/dio/dio_settings.dart';
import '../../../../utils/service_locator.dart/service_locator.dart';

abstract class GetTotalAmountService {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  int monthNumber = DateTime.now().month;
  Map<String, dynamic> _auth = {
    'Authorization': '',
  };
  Future getIncomeTotalAmount({required debtorId});
  Future getOutlayTotalAmount({required debtorId});
}

class GetIncomeTotalAmountService extends GetTotalAmountService {
  @override
  Future getIncomeTotalAmount({required debtorId}) async {
    TotalAmountModel totalAmount = TotalAmountModel(
      amountType: 0,
      totalAmount: 0.0,
    );
    const totalIncomeAmountURL = "/api/statistic/debtor";
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();

    try {
      if (_auth.isNotEmpty) {
        Response response = await _dio.get(
          "$totalIncomeAmountURL/$debtorId/$monthNumber/",
          options: Options(
            headers: _auth,
          ),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> resData = response.data as Map<String, dynamic>;
          if (resData['data'] != null) {
            for (var element in resData['data']) {
              if (element['status'] == "0") {
                totalAmount = TotalAmountModel(
                  amountType: int.parse(element['status']),
                  totalAmount: element['total_amount'] != 0
                      ? int.parse(element['total_amount'].toString()).toDouble()
                      : 0.0,
                );
              }
            }
          }
        }
        return totalAmount;
      }
    } on DioException {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class GetOutlayTotalAmountService extends GetTotalAmountService {
  @override
  Future getOutlayTotalAmount({required debtorId}) async {
    TotalAmountModel totalAmount = TotalAmountModel(
      amountType: 1,
      totalAmount: 0.0,
    );
    const totalIncomeAmountURL = "/api/statistic/debtor";
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();
    try {
      if (_auth.isNotEmpty) {
        Response response = await _dio.get(
          "$totalIncomeAmountURL/$debtorId/$monthNumber/",
          options: Options(
            headers: _auth,
          ),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> resData = response.data as Map<String, dynamic>;
          if (resData['data'] != null) {
            for (var element in resData['data']) {
              if (element['status'] == "1") {
                totalAmount = TotalAmountModel(
                  amountType: int.parse(element['status']),
                  totalAmount: element['total_amount'] != 0
                      ? int.parse(element['total_amount'].toString()).toDouble()
                      : 0.0,
                );
              }
            }
          }
        }
        return totalAmount;
      }
    } on DioException {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
