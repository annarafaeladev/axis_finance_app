import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/entities/sheet_entity.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

abstract class SheetTabsRepository<T extends SheetEntity>
    implements TabsRepository<T> {
  final GoogleSheetsApi api;
  final String sheetName;
  final T Function(List<dynamic> row, int indexRow) fromRow;

  SheetTabsRepository({
    required this.api,
    required this.sheetName,
    required this.fromRow,
  });

  @override
  Future<List<T>> getAll() async {
    final sheetData = await api.getSheetData(sheetName);

    if (sheetData.length <= 1) return [];

    return sheetData
        .skip(1)
        .toList()
        .asMap()
        .entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => fromRow(entry.value, entry.key + 1))
        .toList();
  }

  @override
  Future<void> add(T entity) async {
    await api.appendRow(sheetName, entity.toList());
  }

  @override
  Future<void> update(T entity) async {
    await api.updateRow(sheetName, entity.indexRow, entity.toList());
  }

  @override
  Future<void> delete(int indexRow) async {
    await api.deleteRow(sheetName, indexRow);
  }

  @override
  Future<int> getNextIndex() async {
    final rows = await api.getSheetData(sheetName);
    return rows.skip(1).length + 1;
  }
}
