import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/data/repositories/sheet_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/sheets_repository.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_entry_controller.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/init_finance.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_controller.dart';

void registerFinance() {
  getIt.registerLazySingleton<SheetsRepository>(
  () => SheetsRepositoryImpl(api: getIt<GoogleSheetsApi>()),
);

  getIt.registerLazySingleton(
    () => FinanceController(
      getIt<InitFinance>(),
      getIt<FinanceEntryController>(),
    ),
  );
}
