import '../entities/finance_entry.dart';
import '../repositories/finance_repository.dart';

class GetEntries {
  final FinanceRepository repository;

  GetEntries(this.repository);

  // Future<List<FinanceEntry>> call() {
  //   // return repository.getEntradas();
  // }
}
