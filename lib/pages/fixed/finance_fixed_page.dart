import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/core/enum/form_action.dart';
import 'package:axis_finance_app/core/routes/app_routes.dart';
import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_fixed_expense_controller.dart';
import 'package:axis_finance_app/widgets/fixed/fixa_item.dart';
import 'package:axis_finance_app/pages/fixed/fixe_form_page.dart';
import 'package:axis_finance_app/widgets/common/list_item_dynamic.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/common/content_page_header.dart';
import 'package:axis_finance_app/widgets/common/finance_card.dart';
import 'package:go_router/go_router.dart';

class FinanceFixedPage extends StatefulWidget {
  const FinanceFixedPage({super.key});

  @override
  State<StatefulWidget> createState() => _FinanceFixedPage();
}

class _FinanceFixedPage extends State<FinanceFixedPage> {
  late final FinanceFixedExpenseController _fixeExpenseController;

  @override
  void initState() {
    super.initState();
    _fixeExpenseController = getIt<FinanceFixedExpenseController>();
    // _fixeExpenseController.loadExpenses();
    
    // TODO: utlizar o provider para entregar os dados para a PAGE 
  }

  Future<void> _openEditPage(Fixa item) async {
    final FormResult<Fixa>? result = await context.push(
      AppRoutes.fixedForm,
      extra: item,
    );

    if (result == null) return;

    switch (result.action) {
      case FormAction.create:
        break;
      case FormAction.update:
        _fixeExpenseController.updateExpense(
          result.data!.indexRow,
          result.data!.vencimento,
          result.data!.descricao,
          result.data!.valor,
          result.data!.categoria,
          result.data!.pago,
        );
      case FormAction.delete:
        _fixeExpenseController.deleteEntryByIndex(result.index!);
        break;
    }
  }

  Future<void> _openCreatePage() async {
    final FormResult<Fixa>? result = await context.push(
      AppRoutes.fixedForm
    );

    if (result == null) return;

    switch (result.action) {
      case FormAction.create:
        _fixeExpenseController.addFixed(
          result.data!.vencimento,
          result.data!.descricao,
          result.data!.valor,
          result.data!.categoria,
          result.data!.pago,
        );
        break;
      case FormAction.update:
        _fixeExpenseController.updateExpense(
          result.data!.indexRow,
          result.data!.vencimento,
          result.data!.descricao,
          result.data!.valor,
          result.data!.categoria,
          result.data!.pago,
        );
        break;
      case FormAction.delete:
         break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fixeExpenseController,
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
                onPressed: _openCreatePage,
              ),

              const SizedBox(height: 20),

              FinanceCard(
                title: "Total fixa",
                value: _fixeExpenseController.totalFixasFormatado,
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
                items: _fixeExpenseController.fixas,
                emptyMessage: "Nenhuma saída registrada",
                itemBuilder: (context, item) {
                  return FixaItem(
                    item: item,
                    onEdit: () => _openEditPage(item),
                    onDelete: () => _fixeExpenseController.deleteEntryByIndex(
                      item.indexRow,
                    ),
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
