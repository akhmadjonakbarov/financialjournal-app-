// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';

import '../../../../utils/app_storage.dart';
import '../../../../utils/dio/dio_settings.dart';
import '../../../../utils/service_locator.dart/service_locator.dart';
import '../../models/debtor_model.dart';

abstract class DebtorService {
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

class GetDebtorService implements DebtorService {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  final String _debtorURL = "/api/debtor";

  @override
  Future getDebtor() async {
    List<DebtorModel> debtors = [];
    SecureAppStorage appStorage = SecureAppStorage();
    String? accessToken = await appStorage.getAccessToken();
    try {
      Response response = await _dio.get(
        _debtorURL,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resData = response.data as Map<String, dynamic>;
        if (resData['data'] != []) {
          for (var element in resData['data']) {
            DebtorModel debtor = DebtorModel(
              id: element['id'],
              name: element['name'],
              phonenumber: element['phone'],
            );
            debtors.add(debtor);
          }
        }
        return debtors;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class AddDebtorService extends DebtorService {
  final Dio _dio = serviceLocator<DioSettings>().dio;

  final String _addDebtorURL = "/api/debtor/create";

  @override
  Future addDebtor({required String name, required String phone, required int status}) async {
    SecureAppStorage appStorage = SecureAppStorage();
    String? accessToken = await appStorage.getAccessToken();

    try {
      await _dio.post(
        "$_addDebtorURL?name=$name&phone=$phone&status=$status",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class UpdateDebtorService extends DebtorService {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  final String _updateDebtorURL = "/api/debtor/update";

  @override
  Future updateDebtor({
    required int debtorId,
    required String newName,
    required String newPhone,
  }) async {
    SecureAppStorage appStorage = SecureAppStorage();
    String? accessToken = await appStorage.getAccessToken();

    try {
      await _dio.post(
        "$_updateDebtorURL?id=$debtorId&name=$newName&phone=$newPhone&status=1",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class DeleteDebtorService extends DebtorService {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  final String _deleteDebtorURL = "/api/debtor/delete";

  @override
  Future deleteDebtor({required int debtorId}) async {
    SecureAppStorage appStorage = SecureAppStorage();
    String? accessToken = await appStorage.getAccessToken();

    try {
      await _dio.delete(
        "$_deleteDebtorURL/$debtorId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
