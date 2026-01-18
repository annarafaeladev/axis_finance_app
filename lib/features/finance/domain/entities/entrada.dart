class Entrada {
  final DateTime data;
  final String descricao;
  final double valor;
  final String tipo;

  Entrada({
    required this.data,
    required this.descricao,
    required this.valor,
    required this.tipo,
  });

  static List<String> get header => ['Data', 'Descrição', 'Valor', 'Tipo'];

  factory Entrada.fromList(List<dynamic> row) {
    return Entrada(
      data: DateTime.parse(row[0].toString()),
      descricao: row[1].toString(),
      valor: double.tryParse(row[2].toString()) ?? 0,
      tipo: row[3].toString(),
    );
  }

  /// Converte para uma linha da planilha
  List<dynamic> toList() {
    return [data.toIso8601String(), descricao, valor, tipo];
  }
}
