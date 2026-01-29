import 'package:axis_finance_app/features/finance/data/datasources/google_sheets_api.dart';
import 'package:axis_finance_app/features/finance/domain/entities/configuracao.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/sheet_tab_settings_repository.dart';

class SheetTabSettingsRepositoryImpl implements SheetTabSettingsRepository {
  final GoogleSheetsApi datasource;

  SheetTabSettingsRepositoryImpl(this.datasource);


  @override
  Future<List<Configuracao>> getConfiguracoes() async {
    final map = await datasource.getSettings();

    if (map.isEmpty) {
       return [];
    }

    return map.entries
        .map((e) => Configuracao(chave: e.key, valor: e.value))
        .toList();
  }

  @override
  Future<void> salvarConfiguracoes(List<Configuracao> configuracoes) async {
    final map = {for (var c in configuracoes) c.chave: c.valor};
    await datasource.updateSettings(map);
  }
}
