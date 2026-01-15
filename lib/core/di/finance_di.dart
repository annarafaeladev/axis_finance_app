import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/auth/access_token_provider.dart';
import 'package:flutter_application_1/core/di/injector.dart';
import 'package:flutter_application_1/features/finance/data/datasources/google_sheets_api.dart';
import 'package:flutter_application_1/features/finance/data/repositories/finance_repository_impl.dart';
import 'package:flutter_application_1/features/finance/domain/repositories/finance_repository.dart';
import 'package:flutter_application_1/features/finance/domain/usecases/get_entries.dart';
import 'package:flutter_application_1/features/finance/domain/usecases/init_finance.dart';
import 'package:flutter_application_1/features/finance/presentation/controllers/finance_controller.dart';

void registerFinance() {
  // Datasource
  getIt.registerLazySingleton(
    () => GoogleSheetsApi(getIt<Dio>(), getIt<AccessTokenProvider>()), // GoogleSheetsApi
  );

  // Repository
  getIt.registerLazySingleton<FinanceRepository>(
    () => FinanceRepositoryImpl(getIt<GoogleSheetsApi>()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetEntries(getIt()));
  getIt.registerLazySingleton(() => InitFinance(getIt()));

  // Controller
  getIt.registerFactory(
    () => FinanceController(
      getIt<InitFinance>(),
      getIt<GetEntries>()
    ),
  );
}
