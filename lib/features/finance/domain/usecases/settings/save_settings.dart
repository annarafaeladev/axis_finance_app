
import 'package:axis_finance_app/features/finance/domain/entities/configuracao.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/sheet_tab_settings_repository.dart';

class SaveSettings {
  final SheetTabSettingsRepository repository;

  SaveSettings(this.repository);

  Future<void> call(List<Configuracao> configuracoes) {
    return repository.salvarConfiguracoes(configuracoes);
  }
}
