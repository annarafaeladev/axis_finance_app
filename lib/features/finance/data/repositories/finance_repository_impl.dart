import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final GoogleSheetsApi api;

  FinanceRepositoryImpl(this.api);

  @override
  Future<void> init() {
    return api.findOrCreateSpreadsheet();
  }

  @override
  Future<List<Entrada>> getEntries() async {
    final sheetData = await api.getSheetData('Entradas');

    if (sheetData.length <= 1) return [];

    return sheetData
        .skip(1)
        .toList()
        .asMap()
        .entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) {
          final indexRow = entry.key + 1;
          return Entrada.fromRow(entry.value, indexRow);
        })
        .toList();
  }

  @override
  Future<void> deleteEntry(int indexRow) async {
    await api.deleteRow('Entradas', indexRow);
  }

  @override
  Future<void> addEntry(Entrada entrada) async {
    await api.appendRow('Entradas', entrada.toList());
  }

  @override
  Future<int> getNextIndex() async {
    final rows = await api.getSheetData('Entradas');

    // remove header
    final dataRows = rows.skip(1).toList();

    return dataRows.length + 1;
  }
 
  @override
  Future<void> updateEntry(Entrada entrada) async {
    await api.updateRow('Entradas', entrada.indexRow, entrada.toList());
  }
}
