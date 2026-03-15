import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/add_entry.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/delete_entry.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/get_entries.dart';
import 'package:axis_finance_app/features/finance/domain/usecases/entries/update_entry.dart';
import 'package:flutter/foundation.dart';

class FinanceEntryController extends ChangeNotifier {
  final GetEntries _getEntries;
  final DeleteEntry _deleteEntry;
  final AddEntry _addEntry;
  final UpdateEntry _updateEntry;

  List<Entrada> entradas = [];

  FinanceEntryController(
    this._getEntries,
    this._deleteEntry,
    this._addEntry,
    this._updateEntry,
  );

  double getTotalEntradas() => entradas.fold<double>(0, (sum, e) => sum + e.valor);
  
  String get totalEntradasFormatado {
    final total = getTotalEntradas();

    return 'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}';
  }


  Future<void> init() async {
    await loadEntries();
  }

  Future<void> loadEntries() async {
    entradas = await _getEntries();
    notifyListeners();
  }

  Future<void> deleteEntryByIndex(int indexRow) async {
    await _deleteEntry(indexRow);

    entradas.removeWhere((e) => e.indexRow == indexRow);

    for (final Entrada e in entradas) {
      if (e.indexRow > indexRow) {
        e.copyWith(
          data: e.data,
          descricao: e.descricao,
          valor: e.valor,
          tipo: e.tipo,
          indexRow: e.indexRow - 1,
        );
      }
    }

    notifyListeners();
  }

  Future<void> addEntry(data, descricao, valor, tipo) async {
    Entrada newEntrada = await _addEntry(data, descricao, valor, tipo);
    entradas.add(newEntrada);

    notifyListeners();
  }

  Future<void> updateEntry(
    int indexRow,
    DateTime data,
    String descricao,
    double valor,
    String tipo,
  ) async {
    final index = entradas.indexWhere((e) => e.indexRow == indexRow);

    if (index == -1) return;

    entradas[index] = await _updateEntry(data, descricao, valor, tipo, indexRow);

    notifyListeners();
  }
}
