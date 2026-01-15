import '../repositories/finance_repository.dart';

class InitFinance {
  final FinanceRepository repository;

  InitFinance(this.repository);

  Future<void> call() {
    return repository.init();
  }
}
