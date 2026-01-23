import 'package:axis_finance_app/features/finance/data/repositories/finance_entry_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/add_entry.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/delete_entry.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/update_entry.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_entry_controller.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/get_entries.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/init_finance.dart';

void registerFinanceEntry() {  
  // Repository
  getIt.registerLazySingleton<TabsRepository<Entrada>>(
    () => FinanceEntryRepositoryImpl(getIt<GoogleSheetsApi>()),
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
}
