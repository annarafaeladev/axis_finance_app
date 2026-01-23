import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_fixed_expense_controller.dart';
import 'package:axis_finance_app/widgets/fixed/fixa_item.dart';
import 'package:axis_finance_app/widgets/fixed/new_fixed_expense_modal.dart';
import 'package:axis_finance_app/widgets/list_item_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/content_page_header.dart';
import 'package:axis_finance_app/widgets/finance_card.dart';

class FinanceFixedPage extends StatefulWidget {
  const FinanceFixedPage({super.key});

  @override
  State<StatefulWidget> createState() => _FinanceFixedPage();
}

class _FinanceFixedPage extends State<FinanceFixedPage> {
  late final FinanceFixedExpenseController _expenseController;

  @override
  void initState() {
    super.initState();
    _expenseController = getIt<FinanceFixedExpenseController>();
    _expenseController.loadExpenses();
  }

  void _openCreateModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => NewFixeExpenseModal(
        onSave:
            ({
              required vencimento,
              required descricao,
              required valor,
              required categoria,
              required pago,
            }) async {
              await _expenseController.addFixed(
                vencimento,
                descricao,
                valor,
                categoria,
                pago,
              );
            },
      ),
    );
  }

  void _openUpdateModal(Fixa item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => NewFixeExpenseModal(
        entry: item,
        onSave:
            ({
              required vencimento,
              required descricao,
              required valor,
              required categoria,
              required pago,
            }) async {
              await _expenseController.updateExpense(
                item.indexRow,
                vencimento,
                descricao,
                valor,
                categoria,
                pago,
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
                title: "Despesas Fixas",
                subtitle: "Gerencie suas despesas",
                buttonText: "Nova despesa",
                color: Color(0xFF16A28C),
                onPressed: _openCreateModal,
              ),

              const SizedBox(height: 20),

              FinanceCard(
                title: "Total fixa",
                value: _expenseController.totalFixasFormatado,
                icon: Icons.radio_button_unchecked,
                startColor: Color(0xFFDD2B2B),
                endColor: Color(0xFFE95C38),
              ),

              const SizedBox(height: 20),

              const FinanceCard(
                title: "Pagas este mês",
                value: "R\$ 0.000,00",
                icon: Icons.check_circle,
                startColor: Color(0xFF189E5D),
                endColor: Color(0xFF2EC985),
              ),

              const SizedBox(height: 16),
              ListItemDynamic<Fixa>(
                titulo: "Histórico de Saídas",
                items: _expenseController.fixas,
                emptyMessage: "Nenhuma saída registrada",
                itemBuilder: (context, item) {
                  return FixaItem(
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
