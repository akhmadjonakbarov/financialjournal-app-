import 'package:dio/dio.dart';

import '../../contants/app_urls.dart';
import '../../main.dart';

typedef ConverterFunctionType<T> = T Function(dynamic response);

class DioSettings {
  BaseOptions _dioBaseOptions = BaseOptions(
    baseUrl: mainURL,
    connectTimeout: const Duration(milliseconds: 35000),
    receiveTimeout: const Duration(milliseconds: 35000),
    followRedirects: false,
    // headers: <String, dynamic>{'Accept-Language': StorageRepository.getString(StoreKeys.language, defValue: 'uz')},
    validateStatus: (status) => status != null && status <= 500,
  );

  void setBaseOptions({String? lang, String? baseUrl}) {
    _dioBaseOptions = BaseOptions(
      baseUrl: baseUrl ?? mainURL,
      connectTimeout: const Duration(milliseconds: 35000),
      receiveTimeout: const Duration(milliseconds: 35000),
      headers: <String, dynamic>{'Accept-Language': lang},
      followRedirects: false,
      validateStatus: (status) => status != null && status <= 500,
    );
  }

  BaseOptions get dioBaseOptions => _dioBaseOptions;

  Dio get dio {
    final dio = Dio(_dioBaseOptions);
    dio.interceptors.add(alice.getDioInterceptor());
    // dio.interceptors
    //     /* ..add(CustomInterceptor(dio: dio)) */
    //     .add(
    //   LogInterceptor(
    //     responseBody: true,
    //     requestBody: true,
    //   ),
    // );
    return dio;
  }
}
