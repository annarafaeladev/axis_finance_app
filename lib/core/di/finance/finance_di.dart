import 'package:axis_finance_app/features/finance/presentation/controllers/finance_entry_controller.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/data/repositories/finance_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_repository.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/init_finance.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_controller.dart';

void registerFinance() {
  getIt.registerLazySingleton<FinanceRepository>(
    () => FinanceRepositoryImpl(getIt<GoogleSheetsApi>()),
  );

  getIt.registerLazySingleton(
    () => FinanceController(
      getIt<InitFinance>(),
      getIt<FinanceEntryController>(),
    ),
  );
}
