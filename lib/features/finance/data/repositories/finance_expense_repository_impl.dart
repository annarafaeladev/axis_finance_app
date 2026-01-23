import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_expense_repository.dart';

class FinanceExpenseRepositoryImpl implements FinanceExpenseRepository {
  final GoogleSheetsApi api;

  FinanceExpenseRepositoryImpl(this.api);

  @override
  Future<List<Saida>> getAll() async {
    final sheetData = await api.getSheetData('Saidas');

    if (sheetData.length <= 1) return [];

    return sheetData
        .skip(1)
        .toList()
        .asMap()
        .entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) {
          final indexRow = entry.key + 1;
          return Saida.fromRow(entry.value, indexRow);
        })
        .toList();
  }

  @override
  Future<void> delete(int indexRow) async {
    await api.deleteRow('Saidas', indexRow);
  }

  @override
  Future<void> add(Saida entrada) async {
    await api.appendRow('Saidas', entrada.toList());
  }

  @override
  Future<int> getNextIndex() async {
    final rows = await api.getSheetData('Saidas');

    // remove header
    final dataRows = rows.skip(1).toList();

    return dataRows.length + 1;
  }
 
  @override
  Future<void> update(Saida entrada) async {
    await api.updateRow('Saidas', entrada.indexRow, entrada.toList());
  }
}
