import 'package:axis_finance_app/features/finance/domain/usecases/entries/add_entry.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/delete_entry.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/update_entry.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_entry_controller.dart';
import 'package:dio/dio.dart';
import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/core/storage/local_storage.dart';
import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/data/repositories/finance_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_repository.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/get_entries.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/init_finance.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_controller.dart';

void registerFinance() {
  // Datasource
  getIt.registerLazySingleton<GoogleSheetsApi>(
    () => GoogleSheetsApi(
      driveDio: getIt<Dio>(instanceName: 'driveDio'),
      sheetsDio: getIt<Dio>(instanceName: 'sheetsDio'),
      tokenProvider: getIt<AccessTokenProvider>(),
      localStorage: getIt<LocalStorage>(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<FinanceRepository>(
    () => FinanceRepositoryImpl(getIt<GoogleSheetsApi>()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetEntries(getIt()));
  getIt.registerLazySingleton(() => InitFinance(getIt()));
  getIt.registerLazySingleton(() => DeleteEntry(getIt()));
  getIt.registerLazySingleton(() => AddEntry(getIt()));
  getIt.registerLazySingleton(() => UpdateEntry(getIt()));

  // Controller
  getIt.registerLazySingleton(
    () => FinanceEntryController(
      getIt<GetEntries>(),
      getIt<DeleteEntry>(),
      getIt<AddEntry>(),
      getIt<UpdateEntry>(),
    ),
  );

  getIt.registerLazySingleton(
    () => FinanceController(
      getIt<InitFinance>(),
      getIt<FinanceEntryController>(),
    ),
  );
}
