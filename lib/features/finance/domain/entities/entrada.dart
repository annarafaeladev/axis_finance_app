import 'package:intl/intl.dart';

class Entrada {
  final DateTime data;
  final String descricao;
  final double valor;
  final String tipo;
  int indexRow;

  Entrada({
    required this.data,
    required this.descricao,
    required this.valor,
    required this.tipo,
    required this.indexRow,
  });

  static List<String> get header => [
    'Data',
    'Descrição',
    'Valor',
    'Tipo',
    'id',
  ];

  factory Entrada.fromRow(List<dynamic> row, int indexRow) {
    final formatter = DateFormat('dd/MM/yyyy');
    final data = formatter.parse(row[0]);

    return Entrada(
      data: data,
      descricao: row[1].toString(),
      valor: double.tryParse(row[2].toString()) ?? 0,
      tipo: row[3].toString(),
      indexRow: indexRow,
    );
  }

  Entrada copyWith({
    DateTime? data,
    String? descricao,
    double? valor,
    String? tipo,
  }) {
    return Entrada(
      data: data ?? this.data,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      tipo: tipo ?? this.tipo,
      indexRow: indexRow,
    );
  }

  /// Converte para uma linha da planilha
  List<dynamic> toList() {
    return [DateFormat('dd/MM/yyyy').format(data), descricao, valor, tipo];
  }
}
