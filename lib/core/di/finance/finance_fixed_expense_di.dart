import 'package:axis_finance_app/features/finance/data/repositories/finance_fixed_expense_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/add_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/delete_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/get_expenses.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/update_entry.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/fixes/add_fixed_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/fixes/delete_fixed_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/fixes/get_fixed_expenses.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/fixes/update_fixed_expense.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_fixed_expense_controller.dart';

void registerFinanceFixedExpense() {
  // Repository
  getIt.registerLazySingleton<TabsRepository<Fixa>>(
    () => FinanceFixedExpenseRepositoryImpl(getIt<GoogleSheetsApi>()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetAllFixedExpense(getIt()));
  getIt.registerLazySingleton(() => DeleteFixedExpense(getIt()));
  getIt.registerLazySingleton(() => AddFixedExpense(getIt()));
  getIt.registerLazySingleton(() => UpdateFixedExpense(getIt()));

  // Controller
  getIt.registerLazySingleton(
    () => FinanceFixedExpenseController(
      getIt<GetAllFixedExpense>(),
      getIt<DeleteFixedExpense>(),
      getIt<AddFixedExpense>(),
      getIt<UpdateFixedExpense>(),
    ),
  );
}
