import 'package:axis_finance_app/features/finance/domain/entities/sheet_entity.dart';
import 'package:intl/intl.dart';

class Fixa extends SheetEntity {
  final String descricao;
  final double valor;
  final String categoria;
  final DateTime vencimento;
  final bool pago;

  @override
  final int indexRow;

  Fixa({
    required this.descricao,
    required this.valor,
    required this.categoria,
    required this.vencimento,
    required this.pago,
    required this.indexRow,
  });

  static List<String> get header => [
    'Descrição',
    'Valor',
    'Categoria',
    'Vencimento',
    'Pago',
  ];

  factory Fixa.fromRow(List<dynamic> row, int indexRow) {
    final formatter = DateFormat('dd/MM/yyyy');
    final vencimento = formatter.parse(row[3]);

    return Fixa(
      descricao: row[0].toString(),
      valor: double.tryParse(row[1].toString()) ?? 0,
      categoria: row[2].toString(),
      vencimento: vencimento,
      pago: row[4].toString().toLowerCase() == 'true' || row[4] == '1',
      indexRow: indexRow,
    );
  }

  @override
  List<dynamic> toList() {
    return [
      descricao,
      valor,
      categoria,
      DateFormat('dd/MM/yyyy').format(vencimento),
      pago,
    ];
  }

  Fixa copyWith(
    DateTime vencimento,
    String descricao,
    double valor,
    String categoria,
    bool pago,
    int indexRow,
  ) {
    return Fixa(
      vencimento: vencimento,
      descricao: descricao,
      valor: valor,
      categoria: categoria,
      pago: pago,
      indexRow: this.indexRow,
    );
  }
}
