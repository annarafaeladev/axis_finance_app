import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_expense_controller.dart';
import 'package:axis_finance_app/widgets/expense/new_expense_modal.dart';
import 'package:axis_finance_app/widgets/expense/saida_item.dart';
import 'package:axis_finance_app/widgets/list_item_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/card_list_dynamic.dart';
import 'package:axis_finance_app/widgets/content_page_header.dart';
import 'package:axis_finance_app/widgets/finance_card.dart';

class FinanceOutPage extends StatefulWidget {
  const FinanceOutPage({super.key});

  @override
  State<StatefulWidget> createState() => _FinanceOutPage();
}

class _FinanceOutPage extends State<FinanceOutPage> {
  late final FinanceExpenseController _expenseController;

  @override
  void initState() {
    super.initState();
    _expenseController = getIt<FinanceExpenseController>();
    _expenseController.loadExpenses();
  }

  void _openCreateModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => NewExpenseModal(
        onSave:
            ({
              required data,
              required descricao,
              required valor,
              required categoria,
              required metodoPagamento,
              required status,
            }) async {
              await _expenseController.addExpense(
                data,
                descricao,
                valor,
                categoria,
                metodoPagamento,
                status,
              );
            },
      ),
    );
  }

  void _openUpdateModal(Saida item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => NewExpenseModal(
        entry: item,
        onSave:
            ({
              required data,
              required descricao,
              required valor,
              required categoria,
              required metodoPagamento,
              required status,
            }) async {
              await _expenseController.updateExpense(
                item.indexRow,
                data,
                descricao,
                valor,
                categoria,
                metodoPagamento,
                status,
              );
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _expenseController,
      builder: (_, __) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContentPageHeader(
                title: "Saídas",
                subtitle: "Gerencie suas despesas",
                buttonText: "Nova Despesa",
                color: Color(0xFF16A28C),
                onPressed: _openCreateModal,
              ),

              const SizedBox(height: 20),

              // 🟢 Renda Mensal
              FinanceCard(
                title: "Total de Saídas",
                value: _expenseController.totalSaidasFormatado,
                icon: Icons.trending_down,
                startColor: Color(0xFFDD2B2B),
                endColor: Color(0xFFE95C38),
              ),

              const SizedBox(height: 16),

              ListItemDynamic<Saida>(
                titulo: "Histórico de Saídas",
                items: _expenseController.saidas,
                emptyMessage: "Nenhuma saída registrada",
                itemBuilder: (context, item) {
                  return SaidaItem(
                    item: item,
                    onEdit: () => _openUpdateModal(item),
                    onDelete: () =>
                        _expenseController.deleteEntryByIndex(item.indexRow),
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
