import 'package:dio/dio.dart';
import 'package:financialjournal_app/app/detail/pages/models/Income_model.dart';

import '../../../../../utils/dio/dio_settings.dart';
import '../../../../../utils/generate_auth.dart';
import '../../../../../utils/service_locator.dart/service_locator.dart';

abstract class IncomeOrOutlayService {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  Map<String, dynamic> _auth = {
    'Authorization': '',
  };

  Future<List<IncomeModel>> getIncomeOrOutlay({required int debtorId, required bool isIncome});

  Future addIncomeOrOutlay();

  Future updateIncomeOrOutlay();

  Future deleteIncomeOrOutlay();
}

class GetIncomeOrOutlayService extends IncomeOrOutlayService {
  final _getIncomeOrOutlayURL = "/api/debtor-detail";

  @override
  Future<List<IncomeModel>> getIncomeOrOutlay({required int debtorId, required bool isIncome}) async {
    List<IncomeModel> incomes = [];
    IncomeModel income;
    IncomeModel outlay;
    List<IncomeModel> outlays = [];
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();

    try {
      if (_auth.isNotEmpty) {
        Response response = await _dio.get(
          "$_getIncomeOrOutlayURL/$debtorId",
          options: Options(
            headers: _auth,
          ),
        );

        if (response.statusCode == 200) {
          if (response.data['data'] != []) {
            for (var element in response.data['data']) {
              if (element['status'] == "0") {
                income = IncomeModel(
                  id: element['id'],
                  debtorId: element['debtor_id'],
                  currencyId: int.parse(element['currency_id'].toString()),
                  money: double.parse(element['money'].toString()),
                  expressionHistory: element['expression_history'],
                  status: int.parse(element['status'].toString()),
                  currencyConvert: int.parse(element['currency_convert'].toString()),
                  dateTime: DateTime.parse(element['date']),
                );
                incomes.add(income);
              } else {
                outlay = IncomeModel(
                  id: element['id'],
                  debtorId: element['debtor_id'],
                  currencyId: int.parse(element['currency_id'].toString()),
                  money: double.parse(element['money'].toString()),
                  expressionHistory: element['expression_history'],
                  status: int.parse(element['status'].toString()),
                  currencyConvert: int.parse(element['currency_convert'].toString()),
                  dateTime: DateTime.parse(element['date']),
                );
                outlays.add(outlay);
              }
            }
            if (isIncome) {
              return incomes;
            } else {
              return outlays;
            }
          }
        }
        return incomes;
      }
      return incomes;
    } on DioException {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class AddIncomeService extends IncomeOrOutlayService {
  @override
  Future addIncomeOrOutlay() {
    // TODO: implement addIncomeOrOutlay
    throw UnimplementedError();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
