import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_expense_repository.dart';

class AddExpense {
  final FinanceExpenseRepository repository;

  AddExpense(this.repository);

  Future<Saida> call(
    DateTime data,
    String descricao,
    double valor,
    String categoria,
    String metodoPagamento,
    String status,
  ) async {
    final nextIndex = await repository.getNextIndex();

    final saida = Saida(
      data: data,
      descricao: descricao,
      valor: valor,
      categoria: categoria,
      metodoPagamento: metodoPagamento,
      status: status,
      indexRow: nextIndex,
    );

    await repository.add(saida);

    return saida;
  }
}
