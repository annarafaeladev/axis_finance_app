import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class GetAllFixedExpense {
  final TabsRepository<Fixa> repository;

  GetAllFixedExpense(this.repository);

  Future<List<Fixa>> call() {
    return repository.getAll();
  }
}
