import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/sheets_repository.dart';

class SheetsRepositoryImpl implements SheetsRepository {
  final GoogleSheetsApi api;

  SheetsRepositoryImpl({required this.api});

  @override
  Future<void> initializer() {
    return api.findOrCreateSpreadsheet();
  }
}
