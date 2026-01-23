
import 'package:axis_finance_app/features/finance/domain/repositories/finance_expense_repository.dart';

class DeleteExpense {
  final FinanceExpenseRepository repository;

  DeleteExpense(this.repository);

  Future<void> call(int indexRow) {
    return repository.delete(indexRow);
  }
}
