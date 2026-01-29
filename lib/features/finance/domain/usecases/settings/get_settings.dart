

import 'package:axis_finance_app/features/finance/domain/entities/configuracao.dart';
import 'package:axis_finance_app/features/finance/domain/repositories/sheet_tab_settings_repository.dart';

class GetSettings {
  final SheetTabSettingsRepository repository;

  GetSettings(this.repository);

  Future<List<Configuracao>> call() {
    return repository.getConfiguracoes();
  }
}
