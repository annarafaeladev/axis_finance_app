// Saida.dart
class Saida {
  final DateTime data;
  final String descricao;
  final double valor;
  final String categoria;
  final String metodoPagamento;
  final String status;

  Saida({
    required this.data,
    required this.descricao,
    required this.valor,
    required this.categoria,
    required this.metodoPagamento,
    required this.status,
  });

  static List<String> get header => [
    'Data',
    'Descrição',
    'Valor',
    'Categoria',
    'MetodoPagamento',
    'Status',
  ];

  factory Saida.fromList(List<dynamic> row) {
    return Saida(
      data: DateTime.parse(row[0].toString()),
      descricao: row[1].toString(),
      valor: double.tryParse(row[2].toString()) ?? 0,
      categoria: row[3].toString(),
      metodoPagamento: row[4].toString(),
      status: row[5].toString(),
    );
  }

  List<dynamic> toList() {
    return [data.toIso8601String(), descricao, valor, categoria, metodoPagamento, status];
  }
}
