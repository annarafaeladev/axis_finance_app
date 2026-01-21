
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';

abstract class FinanceRepository {
  Future<void> init();
  Future<void> addEntry(Entrada entrada);
  Future<void> updateEntry(Entrada entrada);
  Future<int> getNextIndex();
  Future<List<Entrada>> getEntries();
  Future<void> deleteEntry(int entryId);
}
