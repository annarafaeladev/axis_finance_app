import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/data/repositories/sheet_tabs_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class FinanceExpenseRepositoryImpl extends SheetTabsRepository<Saida>
    implements TabsRepository<Saida> {
  FinanceExpenseRepositoryImpl(GoogleSheetsApi api)
    : super(
        api: api,
        sheetName: 'Saidas',
        fromRow: (row, index) => Saida.fromRow(row, index),
      );
}
