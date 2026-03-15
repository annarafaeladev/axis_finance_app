import 'package:axis_finance_app/features/finance/data/repositories/sheet_tab_settings_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/sheet_tab_settings_repository.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/settings/get_settings.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/settings/save_settings.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_settings_controller.dart';

void registerFinanceSettings() {
  // Repository
  getIt.registerLazySingleton<SheetTabSettingsRepository>(
    () => SheetTabSettingsRepositoryImpl(getIt<GoogleSheetsApi>()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetSettings(getIt()));
  getIt.registerLazySingleton(() => SaveSettings(getIt()));

  // Controller
  getIt.registerLazySingleton(
    () =>
        FinanceSettingsController(getIt<GetSettings>(), getIt<SaveSettings>()),
  );
}
