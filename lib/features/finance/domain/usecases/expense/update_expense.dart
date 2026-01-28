import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class UpdateExpense {
  final TabsRepository<Saida> repository;

  UpdateExpense(this.repository);

  Future<Saida> call(
    DateTime data,
    String descricao,
    double valor,
    String categoria,
    String metodoPagamento,
    String status,
    int indexRow
  ) async {

    final saida = Saida(
      data: data,
      descricao: descricao,
      valor: valor,
      categoria: categoria,
      metodoPagamento: metodoPagamento,
      status: status,
      indexRow: indexRow,
    );

    await repository.update(saida);

    return saida;
  }
}
