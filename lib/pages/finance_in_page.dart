import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/card_list_dynamic.dart';
import 'package:axis_finance_app/widgets/content_page_header.dart';
import 'package:axis_finance_app/widgets/finance_card.dart';

class FinanceInPage extends StatelessWidget {
  const FinanceInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentPageHeader(
            title: "Entradas",
            subtitle: "Gerencie suas fontes de renda",
            buttonText: "Nova Entrada",
            color: Color(0xFF16A28C),
            onPressed: () {
              // abrir modal ou navegar
            },
          ),

          const SizedBox(height: 20),

          // 🟢 Renda Mensal
          const FinanceCard(
            title: "Total de Entradas",
            value: "R\$ 0.000,00",
            icon: Icons.trending_up,
            startColor: Color(0xFF189E5D),
            endColor: Color(0xFF2EC985),
          ),

          const SizedBox(height: 16),
          CardListDynamic(titulo: "Histórico de Entradas", emptyMessage: "Nenhuma entrada registrada", items: []),
        ],
      ),
    );
  }
}
