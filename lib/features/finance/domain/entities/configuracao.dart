// Configuracao.dart
class Configuracao {
  final String chave;
  final String valor;

  Configuracao({required this.chave, required this.valor});

  static List<String> get header => ['Chave', 'Valor'];
  static List<List<String>> get defaultConfig => [
    ['RendaMensal', '5000'],
    ['PercentualEssenciais', '50'],
    ['PercentualQualidade', '30'],
    ['PercentualFuturo', '20'],
    ['DiaFechamentoCartao', '10'],
    ['DiaVencimentoCartao', '20'],
  ];

  factory Configuracao.fromList(List<dynamic> row) {
    return Configuracao(chave: row[0].toString(), valor: row[1].toString());
  }

  List<dynamic> toList() {
    return [chave, valor];
  }
}
