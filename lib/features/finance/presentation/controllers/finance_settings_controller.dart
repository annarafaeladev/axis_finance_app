import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/configuracao.dart';
import '../../domain/usecases/settings/get_settings.dart';
import '../../domain/usecases/settings/save_settings.dart';

class FinanceSettingsController extends ChangeNotifier {
  final GetSettings _getSettings;
  final SaveSettings _saveSettings;

  FinanceSettingsController(this._getSettings, this._saveSettings);

  List<Configuracao> configuracoes = [];

  // Controllers dos campos (igual form de despesa usa dados prontos)
  final rendaController = TextEditingController();
  final essenciaisController = TextEditingController();
  final qualidadeController = TextEditingController();
  final futuroController = TextEditingController();
  final fechamentoController = TextEditingController();
  final vencimentoController = TextEditingController();

  Future<void> init() async {
    await loadSettings();
  }

  Future<void> loadSettings() async {
    configuracoes = await _getSettings();

    String getValue(String key) {
      return configuracoes
          .firstWhere(
            (c) => c.chave == key,
            orElse: () => Configuracao(chave: key, valor: ''),
          )
          .valor;
    }

    rendaController.text = getValue('RendaMensal');
    essenciaisController.text = getValue('PercentualEssenciais');
    qualidadeController.text = getValue('PercentualQualidade');
    futuroController.text = getValue('PercentualFuturo');
    fechamentoController.text = getValue('DiaFechamentoCartao');
    vencimentoController.text = getValue('DiaVencimentoCartao');

    notifyListeners();
  }

  Future<void> saveSettings() async {
    final novasConfigs = [
      Configuracao(chave: 'RendaMensal', valor: rendaController.text),
      Configuracao(
        chave: 'PercentualEssenciais',
        valor: essenciaisController.text,
      ),
      Configuracao(
        chave: 'PercentualQualidade',
        valor: qualidadeController.text,
      ),
      Configuracao(chave: 'PercentualFuturo', valor: futuroController.text),
      Configuracao(
        chave: 'DiaFechamentoCartao',
        valor: fechamentoController.text,
      ),
      Configuracao(
        chave: 'DiaVencimentoCartao',
        valor: vencimentoController.text,
      ),
    ];

    await _saveSettings(novasConfigs);

    configuracoes = novasConfigs;
    notifyListeners();
  }

  @override
  void dispose() {
    rendaController.dispose();
    essenciaisController.dispose();
    qualidadeController.dispose();
    futuroController.dispose();
    fechamentoController.dispose();
    vencimentoController.dispose();
    super.dispose();
  }

  double rendaMensal() {
    final value = rendaController.text.replaceAll(',', '.');
    return double.tryParse(value) ?? 0.0;
  }

  String get rendaMensalString {
    return 'R\$ ${rendaMensal().toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
