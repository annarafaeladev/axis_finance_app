import 'package:axis_finance_app/features/finance/domain/entities/sheet_entity.dart';
import 'package:intl/intl.dart';

class Saida implements SheetEntity {
  final DateTime data;
  final String descricao;
  final double valor;
  final String categoria;
  final String metodoPagamento;
  final String status;

  @override
  final int indexRow;

  Saida({
    required this.data,
    required this.descricao,
    required this.valor,
    required this.categoria,
    required this.metodoPagamento,
    required this.status,
    required this.indexRow,
  });

  static List<String> get header => [
    'Data',
    'Descrição',
    'Valor',
    'Categoria',
    'MetodoPagamento',
    'Status',
  ];

  factory Saida.fromRow(List<dynamic> row, int indexRow) {
    final formatter = DateFormat('dd/MM/yyyy');
    final data = formatter.parse(row[0]);

    return Saida(
      data: data,
      descricao: row[1].toString(),
      valor: double.tryParse(row[2].toString()) ?? 0,
      categoria: row[3].toString(),
      metodoPagamento: row[4].toString(),
      status: row[5].toString(),
      indexRow: indexRow,
    );
  }

  @override
  List<dynamic> toList() {
    return [
      DateFormat('dd/MM/yyyy').format(data),
      descricao,
      valor,
      categoria,
      metodoPagamento,
      status,
    ];
  }

  Saida copyWith(
    DateTime data,
    String descricao,
    double valor,
    String categoria,
    String metodoPagamento,
    String status,
    int indexRow,
  ) {
    return Saida(
      data: data,
      descricao: descricao,
      valor: valor,
      categoria: categoria,
      metodoPagamento: metodoPagamento,
      status: status,
      indexRow: indexRow,
    );
  }

}
