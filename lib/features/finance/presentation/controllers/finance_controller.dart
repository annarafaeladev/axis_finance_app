import 'package:axis_finance_app/features/finance/domain/usecases/init_finance.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_entry_controller.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_expense_controller.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_fixed_expense_controller.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_settings_controller.dart';
import 'package:flutter/foundation.dart';

class FinanceController extends ChangeNotifier {
  final InitFinance _initFinance;
  final FinanceEntryController _entryController;
  final FinanceExpenseController _expenseController;
  final FinanceFixedExpenseController _fixeController;
  final FinanceSettingsController _settingsController;

  FinanceController(
    this._initFinance,
    this._entryController,
    this._expenseController,
    this._fixeController,
    this._settingsController,
  );

  Future<void> init() async {
    await _initFinance();
  }

  Future<void> initControllers() async {
    await Future.wait([
      _entryController.init(),
      _expenseController.init(),
      _fixeController.init(),
      _settingsController.init(),
    ]);

    notifyListeners();
  }

  String getTotalEntry() {
    return _entryController.totalEntradasFormatado;
  }

  String getTotalSaidas() {
    final total =
        _expenseController.totalSaidas() + _fixeController.totalFixas();
    return 'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String getTotalSaldo() {
    final total =
        _entryController.getTotalEntradas() + _settingsController.rendaMensal();
    return 'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
