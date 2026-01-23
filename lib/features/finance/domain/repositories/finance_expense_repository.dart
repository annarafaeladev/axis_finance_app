import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';

abstract class FinanceExpenseRepository {
  Future<void> add(Saida entrada);
  Future<void> update(Saida entrada);
  Future<int> getNextIndex();
  Future<List<Saida>> getAll();
  Future<void> delete(int entryId);
}
