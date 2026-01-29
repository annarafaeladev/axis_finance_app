

import 'package:axis_finance_app/features/finance/domain/entities/configuracao.dart';

abstract class SheetTabSettingsRepository {
  Future<List<Configuracao>> getConfiguracoes();
  Future<void> salvarConfiguracoes(List<Configuracao> configuracoes);
}
