// Cartao.dart
class Cartao {
  final String nome;
  final double limite;
  final int diaFechamento;
  final int diaVencimento;

  Cartao({
    required this.nome,
    required this.limite,
    required this.diaFechamento,
    required this.diaVencimento,
  });

  static List<String> get header => [
    'Nome',
    'Limite',
    'DiaFechamento',
    'DiaVencimento',
  ];

  factory Cartao.fromList(List<dynamic> row) {
    return Cartao(
      nome: row[0].toString(),
      limite: double.tryParse(row[1].toString()) ?? 0,
      diaFechamento: int.tryParse(row[2].toString()) ?? 0,
      diaVencimento: int.tryParse(row[3].toString()) ?? 0,
    );
  }

  List<dynamic> toList() {
    return [nome, limite, diaFechamento, diaVencimento];
  }
}
