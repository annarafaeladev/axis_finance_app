import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class UpdateEntry {
  final TabsRepository<Entrada> repository;

  UpdateEntry(this.repository);

  Future<Entrada> call(
    DateTime data,
    String descricao,
    double valor,
    String tipo,
    int indexRow
  ) async {
    final entrada = Entrada(
      data: data,
      descricao: descricao,
      valor: valor,
      tipo: tipo,
      indexRow: indexRow,
    );

    await repository.update(entrada);

    return entrada;
  }
}
