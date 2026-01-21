

import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_repository.dart';

class GetEntries {
  final FinanceRepository repository;

  GetEntries(this.repository);

  Future<List<Entrada>> call() {
    return repository.getEntries();
  }
}
