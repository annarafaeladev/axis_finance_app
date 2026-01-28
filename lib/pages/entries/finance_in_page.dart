import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/core/enum/form_action.dart';
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_entry_controller.dart';
import 'package:axis_finance_app/widgets/entries/entrada_item.dart';
import 'package:axis_finance_app/widgets/common/list_item_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/common/content_page_header.dart';
import 'package:axis_finance_app/widgets/common/finance_card.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> _openEditPage(Entrada item) async {
    final FormResult<Entrada>? result = await context.push(
      '/entries/form',
      extra: item,
    );

    if (result == null) return;

    switch (result.action) {
      case FormAction.create:
        break;
      case FormAction.update:
        _entryController.updateEntry(
          result.data!.indexRow,
          result.data!.data,
          result.data!.descricao,
          result.data!.valor,
          result.data!.tipo,
        );
      case FormAction.delete:
        _entryController.deleteEntryByIndex(result.data!.indexRow);
        break;
    }
  }

  Future<void> _openCreatePage() async {
    final FormResult<Entrada>? result = await context.push('/entries/form');

    if (result == null) return;

    switch (result.action) {
      case FormAction.create:
        _entryController.addEntry(
          result.data!.data,
          result.data!.descricao,
          result.data!.valor,
          result.data!.tipo,
        );
        break;
      case FormAction.update:
        _entryController.updateEntry(
          result.data!.indexRow,
          result.data!.data,
          result.data!.descricao,
          result.data!.valor,
          result.data!.tipo,
        );
        break;
      case FormAction.delete:
        break;
    }
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
                onPressed: _openCreatePage,
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

              ListItemDynamic<Entrada>(
                titulo: "Histórico de Entradas",
                items: _entryController.entradas,
                emptyMessage: "Nenhuma entrada registrada",
                itemBuilder: (context, item) {
                  return EntradaItem(
                    item: item,
                    onEdit: () => _openEditPage(item),
                    onDelete: () =>
                        _entryController.deleteEntryByIndex(item.indexRow),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
