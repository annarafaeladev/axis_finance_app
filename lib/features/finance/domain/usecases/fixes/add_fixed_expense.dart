import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class AddFixedExpense {
  final TabsRepository<Fixa> repository;

  AddFixedExpense(this.repository);

  Future<Fixa> call(
     DateTime vencimento,
    String descricao,
    double valor,
    String categoria,
    bool pago,
  ) async {
final nextIndex = await repository.getNextIndex();

    final fixa = Fixa(
      categoria: categoria,
      descricao: descricao,
      pago: pago,
      valor: valor,
      vencimento: vencimento,
      indexRow: nextIndex
    );

    await repository.update(fixa);

    return fixa;

  }
}
