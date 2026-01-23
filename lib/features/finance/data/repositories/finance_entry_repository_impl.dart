import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/data/repositories/sheet_tabs_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class FinanceEntryRepositoryImpl extends SheetTabsRepository<Entrada>
    implements TabsRepository<Entrada> {
  FinanceEntryRepositoryImpl(GoogleSheetsApi api)
    : super(
        api: api,
        sheetName: 'Entradas',
        fromRow: (row, index) => Entrada.fromRow(row, index),
      );
}