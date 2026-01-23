import 'package:axis_finance_app/features/finance/domain/entities/sheet_entity.dart';
import 'package:intl/intl.dart';

class Entrada implements SheetEntity {
  final DateTime data;
  final String descricao;
  final double valor;
  final String tipo;

  @override
  final indexRow;

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
    int? indexRow,
  }) {
    return Entrada(
      data: data ?? this.data,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      tipo: tipo ?? this.tipo,
      indexRow: indexRow ?? this.indexRow,
    );
  }

  @override
  List<dynamic> toList() {
    return [DateFormat('dd/MM/yyyy').format(data), descricao, valor, tipo];
  }
}
