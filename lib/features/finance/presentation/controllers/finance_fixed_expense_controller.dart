import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/fixes/add_fixed_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/fixes/delete_fixed_expense.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/fixes/get_fixed_expenses.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/fixes/update_fixed_expense.dart';
import 'package:flutter/foundation.dart';

class FinanceFixedExpenseController extends ChangeNotifier {
  final GetAllFixedExpense _getAllFixedExpense;
  final DeleteFixedExpense _deleteFixedExpense;
  final AddFixedExpense _addFixedExpense;
  final UpdateFixedExpense _updateFixedExpense;

  List<Fixa> fixas = [];

  FinanceFixedExpenseController(
    this._getAllFixedExpense,
    this._deleteFixedExpense,
    this._addFixedExpense,
    this._updateFixedExpense,
  );

  double totalFixas() => fixas.fold<double>(0, (sum, e) => sum + e.valor);
  
  String get totalFixasFormatado {
    final total = totalFixas();

    return 'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}';
  }


  Future<void> init() async {
    await loadExpenses();
  }

  Future<void> loadExpenses() async {
    fixas = await _getAllFixedExpense();
    notifyListeners();
  }

  Future<void> deleteEntryByIndex(int indexRow) async {
    await _deleteFixedExpense(indexRow);

    fixas.removeWhere((e) => e.indexRow == indexRow);

    for (final Fixa e in fixas) {
      if (e.indexRow > indexRow) {
        e.copyWith(
          e.vencimento,
          e.descricao,
          e.valor,
          e.categoria,
          e.pago,
          e.indexRow - 1,
        );
      }
    }

    notifyListeners();
  }

  Future<void> addFixed(
    DateTime data,
    String descricao,
    double valor,
    String categoria,
    bool pago,
  ) async {
    Fixa newFixed = await _addFixedExpense(
      data,
      descricao,
      valor,
      categoria,
      pago,
    );
    fixas.add(newFixed);

    notifyListeners();
  }

  Future<void> updateExpense(
    int indexRow,
    DateTime vencimento,
    String descricao,
    double valor,
    String categoria,
    bool pago
  ) async {
    final index = fixas.indexWhere((e) => e.indexRow == indexRow);

    if (index == -1) return;

    fixas[index] = await _updateFixedExpense(
      vencimento,
      descricao,
      valor,
      categoria,
      pago,
      index,
    );

    notifyListeners();
  }
}
