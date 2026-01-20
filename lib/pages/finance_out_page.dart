import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/card_list_dynamic.dart';
import 'package:axis_finance_app/widgets/content_page_header.dart';
import 'package:axis_finance_app/widgets/finance_card.dart';

class FinanceOutPage extends StatelessWidget {
  const FinanceOutPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              // abrir modal ou navegar
            },
          ),
         
          const SizedBox(height: 20),
        
          // 🟢 Renda Mensal
          const FinanceCard(
            title: "Total de Saídas",
            value: "R\$ 0.000,00",
            icon: Icons.trending_up,
            startColor: Color(0xFFDD2B2B),
            endColor: Color(0xFFE95C38),
          ),

          const SizedBox(height: 16),

          CardListDynamic(titulo: "Histórico de Saídas", emptyMessage: "Nenhuma saída registrada", items: []),
        ],
      ),
    );
  }
}
