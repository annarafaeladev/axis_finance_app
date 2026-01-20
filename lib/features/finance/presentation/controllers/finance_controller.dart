import 'package:axis_finance_app/features/finance/domain/usecases/init_finance.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_entry_controller.dart';
import 'package:flutter/foundation.dart';

class FinanceController extends ChangeNotifier {
  final InitFinance _initFinance;
  final FinanceEntryController _entryController;


  FinanceController(
    this._initFinance, this._entryController,
   
  );

  Future<void> init() async {
    await _initFinance();
  }

 String getTotalEntry() {
    return _entryController.totalEntradasFormatado;
 }
 
}
