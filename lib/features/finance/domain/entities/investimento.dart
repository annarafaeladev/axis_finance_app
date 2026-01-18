// Investimento.dart
class Investimento {
  final DateTime data;
  final String tipo;
  final double valor;
  final String conta;
  final String status;

  Investimento({
    required this.data,
    required this.tipo,
    required this.valor,
    required this.conta,
    required this.status,
  });

  static List<String> get header => [
    'Data',
    'Tipo',
    'Valor',
    'Conta',
    'Status',
  ];

  factory Investimento.fromList(List<dynamic> row) {
    return Investimento(
      data: DateTime.parse(row[0].toString()),
      tipo: row[1].toString(),
      valor: double.tryParse(row[2].toString()) ?? 0,
      conta: row[3].toString(),
      status: row[4].toString(),
    );
  }

  List<dynamic> toList() {
    return [data.toIso8601String(), tipo, valor, conta, status];
  }
}
