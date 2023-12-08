import 'package:dio/dio.dart';
import 'package:financialjournal_app/app/common/models/kurs_model.dart';
import 'package:financialjournal_app/utils/generate_auth.dart';

import '../../../../utils/dio/dio_settings.dart';
import '../../../../utils/service_locator.dart/service_locator.dart';

abstract class KursService {
  final Dio _dio = serviceLocator<DioSettings>().dio;
  Map<String, dynamic> _auth = {
    'Authorization': '',
  };

  Future<List<KursModel>> getKurss();

  Future<KursModel> getSingleKurs();

  Future addKurs({required double kurs});

  Future update({required double newKurs});

  Future deleteKurs({required kursId});
}

class GetKursService extends KursService {
  final String _getKurssURL = "/api/currency";
  final String _oneCurrency = "/api/currency/one";

  @override
  Future<List<KursModel>> getKurss() async {
    List<KursModel> kurss = [];
    KursModel kursModel;
    GenerateAuth generateAuth = GenerateAuth();

    _auth = await generateAuth.auth();

    try {
      if (_auth.isNotEmpty) {
        Response response = await _dio.get(
          _getKurssURL,
          options: Options(
            headers: _auth,
          ),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> resData = response.data as Map<String, dynamic>;
          if (response.data['data'] != []) {
            for (var element in resData['data']) {
              kursModel = KursModel(
                id: element['id'],
                currency: double.parse(element['currency'].toString()),
                userId: element['user_id'],
                createdAt: DateTime.parse(element['created_at']),
              );
              kurss.add(kursModel);
            }
          }
          return kurss;
        }
      }
      return kurss;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<KursModel> getSingleKurs() async {
    KursModel kursModel;
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();
    try {
      if (_auth.isNotEmpty) {
        Response response = await _dio.get(
          _oneCurrency,
          options: Options(headers: _auth),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> resData = response.data as Map<String, dynamic>;
          if (resData['data'] != null) {
            kursModel = KursModel(
              id: resData['data']['id'],
              currency: double.parse(resData['data']['currency']),
              userId: resData['data']['user_id'],
              createdAt: DateTime.parse(resData['data']['created_at']),
            );
            return kursModel;
          }
        }
      }
      return KursModel(
        id: -1,
        currency: 0.0,
        userId: -1,
        createdAt: DateTime.now(),
      );
    } on DioException {
      rethrow;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class AddKursService extends KursService {
  final String _addKursURL = "/api/currency/create";

  @override
  Future addKurs({required double kurs}) async {
    GenerateAuth generateAuth = GenerateAuth();
    _auth = await generateAuth.auth();
    try {
      if (_auth.isNotEmpty) {
        await _dio.post(
          "$_addKursURL?currency=$kurs",
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
