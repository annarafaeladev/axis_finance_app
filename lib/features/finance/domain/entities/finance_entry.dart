class FinanceEntry {
  final String id;
  final DateTime date;
  final String description;
  final double value;
  final String category;
  final String type; // entrada | saida
  final String paymentMethod;
  final String status;

  FinanceEntry({
    required this.id,
    required this.date,
    required this.description,
    required this.value,
    required this.category,
    required this.type,
    required this.paymentMethod,
    required this.status,
  });
}
