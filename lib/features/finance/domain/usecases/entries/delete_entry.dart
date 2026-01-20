
import 'package:axis_finance_app/features/finance/domain/repositories/finance_repository.dart';

class DeleteEntry {
  final FinanceRepository repository;

  DeleteEntry(this.repository);

  Future<void> call(int indexRow) {
    return repository.deleteEntry(indexRow);
  }
}
