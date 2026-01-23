import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_expense_repository.dart';

class GetAllExpense {
  final FinanceExpenseRepository repository;

  GetAllExpense(this.repository);

  Future<List<Saida>> call() {
    return repository.getAll();
  }
}
