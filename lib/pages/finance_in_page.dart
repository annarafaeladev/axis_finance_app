import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_entry_controller.dart';
import 'package:axis_finance_app/widgets/new_entry_modal.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/card_list_dynamic.dart';
import 'package:axis_finance_app/widgets/content_page_header.dart';
import 'package:axis_finance_app/widgets/finance_card.dart';

class FinanceInPage extends StatefulWidget {
  const FinanceInPage({super.key});

  @override
  State<FinanceInPage> createState() => _FinanceInPageState();
}

class _FinanceInPageState extends State<FinanceInPage> {
  late final FinanceEntryController _entryController;

  @override
  void initState() {
    super.initState();
    _entryController = getIt<FinanceEntryController>();
    _entryController.loadEntries();
  }

  void _openCreateModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => NewEntryModal(
        onSave:
            ({
              required data,
              required descricao,
              required valor,
              required tipo,
            }) async {
              await _entryController.addEntry(data, descricao, valor, tipo);
            },
      ),
    );
  }

  void _openUpdateModal(Entrada item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => NewEntryModal(
        entry: item,
        onSave:
            ({
              required data,
              required descricao,
              required valor,
              required tipo,
            }) async  {
              await _entryController.updateEntry(
                item.indexRow,
                data,
                descricao,
                valor,
                tipo,
              );
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _entryController,
      builder: (_, __) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContentPageHeader(
                title: "Entradas",
                subtitle: "Gerencie suas fontes de renda",
                buttonText: "Nova Entrada",
                color: const Color(0xFF16A28C),
                onPressed: _openCreateModal,
              ),

              const SizedBox(height: 20),

              FinanceCard(
                title: "Total de Entradas",
                value: _entryController.totalEntradasFormatado,
                icon: Icons.trending_up,
                startColor: const Color(0xFF189E5D),
                endColor: const Color(0xFF2EC985),
              ),

              const SizedBox(height: 16),

              CardListDynamic(
                titulo: "Histórico de Entradas",
                emptyMessage: "Nenhuma entrada registrada",
                items: _entryController.entradas,
                onPressedUpdateItem: (item) => _openUpdateModal(item),
                onPressed: (item) =>
                    _entryController.deleteEntryByIndex(item.indexRow),
              ),
            ],
          ),
        );
      },
    );
  }
}
