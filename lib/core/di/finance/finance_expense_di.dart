import 'package:axis_finance_app/features/finance/data/repositories/finance_expense_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_expense_repository.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/add_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/delete_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/get_expenses.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/update_entry.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_expense_controller.dart';

void registerFinanceExpense() {
  // Repository
  getIt.registerLazySingleton<FinanceExpenseRepository>(
    () => FinanceExpenseRepositoryImpl(getIt<GoogleSheetsApi>()),
  );

  // UseCases
  getIt.registerLazySingleton(() => GetAllExpense(getIt()));
  getIt.registerLazySingleton(() => DeleteExpense(getIt()));
  getIt.registerLazySingleton(() => AddExpense(getIt()));
  getIt.registerLazySingleton(() => UpdateExpense(getIt()));

  // Controller
  getIt.registerLazySingleton(
    () => FinanceExpenseController(
      getIt<GetAllExpense>(),
      getIt<DeleteExpense>(),
      getIt<AddExpense>(),
      getIt<UpdateExpense>(),
    ),
  );
}
