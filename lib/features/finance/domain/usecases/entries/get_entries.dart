

import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_entry_repository.dart';

class GetEntries {
  final FinanceEntryRepository repository;

  GetEntries(this.repository);

  Future<List<Entrada>> call() {
    return repository.getEntries();
  }
}
