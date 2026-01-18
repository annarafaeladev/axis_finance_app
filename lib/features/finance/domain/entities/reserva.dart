// Reserva.dart
class Reserva {
  final DateTime data;
  final double valor;
  final double total;

  Reserva({required this.data, required this.valor, required this.total});

  static List<String> get header => ['Data', 'Valor', 'Total'];

  factory Reserva.fromList(List<dynamic> row) {
    return Reserva(
      data: DateTime.parse(row[0].toString()),
      valor: double.tryParse(row[1].toString()) ?? 0,
      total: double.tryParse(row[2].toString()) ?? 0,
    );
  }

  List<dynamic> toList() {
    return [data.toIso8601String(), valor, total];
  }
}
