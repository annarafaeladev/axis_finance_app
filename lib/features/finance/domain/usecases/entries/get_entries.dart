import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class GetEntries {
  final TabsRepository<Entrada> repository;

  GetEntries(this.repository);

  Future<List<Entrada>> call() {
    return repository.getAll();
  }
}
