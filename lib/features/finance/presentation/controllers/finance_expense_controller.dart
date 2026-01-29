import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/add_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/delete_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/get_expenses.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/expense/update_expense.dart';
import 'package:flutter/foundation.dart';

class FinanceExpenseController extends ChangeNotifier {
  final GetAllExpense _getAllExpense;
  final DeleteExpense _deleteExpense;
  final AddExpense _addExpense;
  final UpdateExpense _updateExpense;

  List<Saida> saidas = [];

  FinanceExpenseController(
    this._getAllExpense,
    this._deleteExpense,
    this._addExpense,
    this._updateExpense,
  );

  double totalSaidas() => saidas.fold<double>(0, (sum, e) => sum + e.valor);

  String get totalSaidasFormatado {
    return 'R\$ ${totalSaidas().toStringAsFixed(2).replaceAll('.', ',')}';
  }

  Future<void> init() async {
    await loadExpenses();
  }

  Future<void> loadExpenses() async {
    saidas = await _getAllExpense();
    notifyListeners();
  }

  Future<void> deleteEntryByIndex(int indexRow) async {
    await _deleteExpense(indexRow);

    saidas.removeWhere((e) => e.indexRow == indexRow);

    for (final Saida e in saidas) {
      if (e.indexRow > indexRow) {
        e.copyWith(
          e.data,
          e.descricao,
          e.valor,
          e.categoria,
          e.metodoPagamento,
          e.status,
          e.indexRow - 1,
        );
      }
    }

    notifyListeners();
  }

  Future<void> addExpense(
    DateTime data,
    String descricao,
    double valor,
    String categoria,
    String metodoPagamento,
    String status,
  ) async {
    Saida newEntrada = await _addExpense(
      data,
      descricao,
      valor,
      categoria,
      metodoPagamento,
      status,
    );
    saidas.add(newEntrada);

    notifyListeners();
  }

  Future<void> updateExpense(
    int indexRow,
    DateTime data,
    String descricao,
    double valor,
    String categoria,
    String metodoPagamento,
    String status,
  ) async {
    final index = saidas.indexWhere((e) => e.indexRow == indexRow);

    if (index == -1) return;

    saidas[index] = await _updateExpense(
      data,
      descricao,
      valor,
      categoria,
      metodoPagamento,
      status,
      indexRow,
    );

    notifyListeners();
  }
}
