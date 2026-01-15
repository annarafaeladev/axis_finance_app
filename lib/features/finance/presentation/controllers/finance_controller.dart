import '../../domain/entities/finance_entry.dart';
import '../../domain/usecases/get_entries.dart';
import '../../domain/usecases/init_finance.dart';

class FinanceController {
  final InitFinance initFinance;
  final GetEntries getEntries;

  FinanceController(this.initFinance, this.getEntries);

  Future<void> init() async {
    await initFinance();
  }

  // Future<List<FinanceEntry>> load() {
  //   return getEntries();
  // }
}
