import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class DeleteExpense {
  final TabsRepository<Saida> repository;

  DeleteExpense(this.repository);

  Future<void> call(int indexRow) {
    return repository.delete(indexRow);
  }
}
