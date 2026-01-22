
import 'package:axis_finance_app/features/finance/domain/repositories/finance_entry_repository.dart';

class DeleteEntry {
  final FinanceEntryRepository repository;

  DeleteEntry(this.repository);

  Future<void> call(int indexRow) {
    return repository.deleteEntry(indexRow);
  }
}
