import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class GetAllExpense {
  final TabsRepository<Saida> repository;

  GetAllExpense(this.repository);

  Future<List<Saida>> call() {
    return repository.getAll();
  }
}
