import 'package:axis_finance_app/features/finance/domain/repositories/sheets_repository.dart';

class InitFinance {
  final SheetsRepository repository;

  InitFinance(this.repository);

  Future<void> call() {
    return repository.initializer();
  }
}
