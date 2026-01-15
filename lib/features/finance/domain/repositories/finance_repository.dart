import '../entities/finance_entry.dart';
import '../entities/finance_settings.dart';

abstract class FinanceRepository {
  Future<void> init();
  // Future<List<FinanceEntry>> getEntradas();
  // Future<void> addEntrada(FinanceEntry entry);
  // Future<FinanceSettings> getSettings();
  // Future<void> updateSettings(FinanceSettings settings);
}
