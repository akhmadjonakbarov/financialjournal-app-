import 'package:get_it/get_it.dart';

import '../dio/dio_settings.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  serviceLocator.registerLazySingleton(() => DioSettings());
}
