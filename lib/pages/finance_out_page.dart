import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/core/enum/form_action.dart';
import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_expense_controller.dart';
import 'package:axis_finance_app/widgets/expense/expense_form_page.dart';
import 'package:axis_finance_app/widgets/expense/saida_item.dart';
import 'package:axis_finance_app/widgets/common/list_item_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/common/content_page_header.dart';
import 'package:axis_finance_app/widgets/common/finance_card.dart';

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

  Future<void> _openEditPage(Saida item) async {
  final FormResult<Saida>? result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => SaidaFormPage(entry: item),
    ),
  );

  if (result == null) return;

  switch (result.action) {
    case FormAction.create:
      // não esperado em edição
      break;
    case FormAction.update:
        // não deve acontecer aqui, mas evita crash
        _expenseController.updateExpense(
          result.data!.indexRow,
          result.data!.data,
          result.data!.descricao,
          result.data!.valor,
          result.data!.categoria,
          result.data!.metodoPagamento,
          result.data!.status
        );
    case FormAction.delete:
      _expenseController.deleteEntryByIndex(result.index!);
      break;
  }
}


  Future<void> _openCreatePage() async {
    final FormResult<Saida>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SaidaFormPage()),
    );

    if (result == null) return;

    switch (result.action) {
      case FormAction.create:
        _expenseController.addExpense(
          result.data!.data,
          result.data!.descricao,
          result.data!.valor,
          result.data!.categoria,
          result.data!.metodoPagamento,
          result.data!.status
        );
        break;
      case FormAction.update:
        // não deve acontecer aqui, mas evita crash
        _expenseController.updateExpense(
          result.data!.indexRow,
          result.data!.data,
          result.data!.descricao,
          result.data!.valor,
          result.data!.categoria,
          result.data!.metodoPagamento,
          result.data!.status
        );
        break;
      case FormAction.delete:
        // não faz sentido ao criar, então ignora
        break;
    }
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
                onPressed: _openCreatePage,
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
                    onEdit: () => _openEditPage(item),
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
