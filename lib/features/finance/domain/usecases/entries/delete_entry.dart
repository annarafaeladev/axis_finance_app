import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class DeleteEntry {
  final TabsRepository<Entrada> repository;

  DeleteEntry(this.repository);

  Future<void> call(int indexRow) {
    return repository.delete(indexRow);
  }
}
