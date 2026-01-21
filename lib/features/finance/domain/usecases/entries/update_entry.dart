import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_repository.dart';

class UpdateEntry {
  final FinanceRepository repository;

  UpdateEntry(this.repository);

  Future<Entrada> call(
    DateTime data,
    String descricao,
    double valor,
    String tipo,
  ) async {
    final nextIndex = await repository.getNextIndex();

    final entrada = Entrada(
      data: data,
      descricao: descricao,
      valor: valor,
      tipo: tipo,
      indexRow: nextIndex,
    );

    await repository.updateEntry(entrada);

    return entrada;
  }
}
