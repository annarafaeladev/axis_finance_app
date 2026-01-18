// Fixa.dart
class Fixa {
  final String descricao;
  final double valor;
  final String categoria;
  final int vencimento;
  final bool pago;

  Fixa({
    required this.descricao,
    required this.valor,
    required this.categoria,
    required this.vencimento,
    required this.pago,
  });

  static List<String> get header => [
    'Descrição',
    'Valor',
    'Categoria',
    'Vencimento',
    'Pago',
  ];

  factory Fixa.fromList(List<dynamic> row) {
    return Fixa(
      descricao: row[0].toString(),
      valor: double.tryParse(row[1].toString()) ?? 0,
      categoria: row[2].toString(),
      vencimento: int.tryParse(row[3].toString()) ?? 0,
      pago: row[4].toString().toLowerCase() == 'true' || row[4] == '1',
    );
  }

  List<dynamic> toList() {
    return [descricao, valor, categoria, vencimento, pago];
  }
}
