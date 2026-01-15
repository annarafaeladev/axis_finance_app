
import 'package:flutter_application_1/features/finance/data/datasources/google_sheets_api.dart';
import 'package:flutter_application_1/features/finance/domain/repositories/finance_repository.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final GoogleSheetsApi api;

  FinanceRepositoryImpl(this.api);

  @override
  Future<void> init() {
    return api.findOrCreateSpreadsheet();
  }

  // @override
  // Future<void> addEntrada(FinanceEntry entry) {
  //   // return api.append('Entradas', [
  //   //   entry.date.toIso8601String(),
  //   //   entry.description,
  //   //   entry.value,
  //   //   entry.category,
  //   //   entry.paymentMethod,
  //   //   entry.status,
  //   // ]);

  // }

  // @override
  // Future<List<FinanceEntry>> getEntradas() async {
  //   final rows = await api.getSheet('Entradas');

  //   return rows.skip(1).map((row) {
  //     return FinanceEntry(
  //       id: '',
  //       date: DateTime.parse(row[0]),
  //       description: row[1],
  //       value: double.parse(row[2].toString()),
  //       category: row[3],
  //       type: 'entrada',
  //       paymentMethod: row[4],
  //       status: row[5],
  //     );
  //   }).toList();
  // }

  // @override
  // Future<FinanceSettings> getSettings() {
  //   throw UnimplementedError();
  // }

  // @override
  // Future<void> updateSettings(FinanceSettings settings) {
  //   throw UnimplementedError();
  // }
}
