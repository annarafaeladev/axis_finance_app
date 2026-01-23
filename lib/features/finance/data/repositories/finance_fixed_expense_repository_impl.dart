import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/data/repositories/sheet_tabs_repository_impl.dart';
import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/tabs_repository.dart';

class FinanceFixedExpenseRepositoryImpl extends SheetTabsRepository<Fixa>
    implements TabsRepository<Fixa> {
  FinanceFixedExpenseRepositoryImpl(GoogleSheetsApi api)
    : super(
        api: api,
        sheetName: 'Fixas',
        fromRow: (row, index) => Fixa.fromRow(row, index),
      );
}
