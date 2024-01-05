import 'package:dio/dio.dart';

import '../../../../../utils/dio/dio_settings.dart';
import '../../../../../utils/generate_auth.dart';
import '../../../../../utils/service_locator.dart/service_locator.dart';
import '../../models/income_model.dart';

abstract class IncomeOrOutlayService {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  Map<String, dynamic> _auth = {
    'Authorization': '',
  };

  Future<List<IncomeModel>> getIncomeOrOutlay({required int debtorId, required bool isIncome});

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

class GetIncomeOrOutlayService extends IncomeOrOutlayService {
  final _getIncomeOrOutlayURL = "/api/debtor-detail";

  @override
  Future<List<IncomeModel>> getIncomeOrOutlay({required int debtorId, required bool isIncome}) async {
    List<IncomeModel> incomes = [];
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
              IncomeModel model = IncomeModel(
                id: element['id'],
                debtorId: element['debtor_id'],
                currencyId: int.parse(element['currency_id'].toString()),
                money: double.parse(element['money'].toString()),
                expressionHistory: element['expression_history'],
                status: int.parse(element['status'].toString()),
                currencyConvert: int.parse(element['currency_convert'].toString()),
                dateTime: DateTime.parse(element['date']),
              );

              if (element['status'] == "0") {
                incomes.add(model);
              } else {
                outlays.add(model);
              }
            }

            return isIncome ? incomes : outlays;
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

class AddIncomeOrOutlayService extends IncomeOrOutlayService {
  final String _addIncomeURL = "/api/debtor-detail/create";

  @override
  Future addIncomeOrOutlay({
    required int debtorId,
    required int currencyId,
    required int currencyConvert,
    required String expressionHistory,
    required double money,
    required int status,
    required DateTime dateTime,
  }) async {
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();
    try {
      if (status == 0) {
        await _dio.post(
          "$_addIncomeURL?debtor_id=$debtorId&money=$money&status=$status&currency_id=$currencyId&date=$dateTime&expression_history=$expressionHistory&currency_convert=$currencyConvert",
          options: Options(
            headers: _auth,
          ),
        );
      } else {
        await _dio.post(
          "$_addIncomeURL?debtor_id=$debtorId&money=$money&status=$status&currency_id=$currencyId&date=$dateTime&expression_history=$expressionHistory&currency_convert=$currencyConvert",
          options: Options(
            headers: _auth,
          ),
        );
      }
    } on DioException {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UpdateIncomeOrOutlayService extends IncomeOrOutlayService {
  final String _updateIncomeOrOutlayURL = "/api/debtor-detail/update";
  @override
  Future updateIncomeOrOutlay({
    required int id,
    required int debtorId,
    required int currencyId,
    required int currencyConvert,
    required String expressionHistory,
    required double money,
    required int status,
    required DateTime dateTime,
  }) async {
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();
    try {
      if (_auth.isNotEmpty) {
        await _dio.put(
          "$_updateIncomeOrOutlayURL/$id?debtor_id=$debtorId&money=$money&status=$status&currency_id=$currencyId&date=$dateTime&expression_history=$expressionHistory&currency_convert=$currencyConvert",
          options: Options(
            headers: _auth,
          ),
        );
      }
    } on DioException {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DeleteIncomeOrOutlayService extends IncomeOrOutlayService {
  final String _deleteIncomeOrOutlayURL = "/api/debtor-detail/delete";
  @override
  Future deleteIncomeOrOutlay({required int id}) async {
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();
    try {
      if (_auth.isNotEmpty) {
        await _dio.delete(
          "$_deleteIncomeOrOutlayURL/$id",
          options: Options(
            headers: _auth,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
