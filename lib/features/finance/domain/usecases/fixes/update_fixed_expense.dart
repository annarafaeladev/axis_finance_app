import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class UpdateFixedExpense {
  final TabsRepository<Fixa> repository;

  UpdateFixedExpense(this.repository);

  Future<Fixa> call(
    DateTime vencimento,
    String descricao,
    double valor,
    String categoria,
    bool pago,
    int indexRow
  ) async {
    final fixa = Fixa(
      categoria: categoria,
      descricao: descricao,
      pago: pago,
      valor: valor,
      vencimento: vencimento,
      indexRow: indexRow
    );

    await repository.update(fixa);

    return fixa;
  }
}
