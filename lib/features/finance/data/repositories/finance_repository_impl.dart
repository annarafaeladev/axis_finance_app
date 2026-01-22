import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final GoogleSheetsApi api;

  FinanceRepositoryImpl(this.api);

  @override
  Future<void> init() {
    return api.findOrCreateSpreadsheet();
  }
}
