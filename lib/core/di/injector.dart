import 'package:dio/dio.dart';
import 'package:axis_finance_app/core/di/finance_di.dart';
import 'package:get_it/get_it.dart';
import '../storage/local_storage.dart';
import 'auth_di.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Infra global
  getIt.registerLazySingleton(() => LocalStorage());
  getIt.registerLazySingleton(() => Dio());

  // Features
  registerAuth();
  registerFinance();
}
