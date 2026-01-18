class Setupsheet {
  final List<String> header;
  final List<List<String>>? defaultRows;

  const Setupsheet({
    required this.header,
    this.defaultRows,
  });
}
