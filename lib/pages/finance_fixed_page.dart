import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/card_list_dynamic.dart';
import 'package:flutter_application_1/widgets/content_page_header.dart';
import 'package:flutter_application_1/widgets/finance_card.dart';

class FinanceFixedPage extends StatelessWidget {
  const FinanceFixedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentPageHeader(
            title: "Despesas Fixas",
            subtitle: "Gerencie suas despesas",
            buttonText: "Nova despesa",
            color: Color.fromARGB(255, 14, 160, 68),
            onPressed: () {
              // abrir modal ou navegar
            },
          ),

          const SizedBox(height: 20),

          const FinanceCard(
            title: "Total fixa",
            value: "R\$ 0.000,00",
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
          CardListDynamic(
            titulo: "Lista de despesas Fixas",
            emptyMessage: "Nenhuma despesa registrada",
            items: [],
          ),
        ],
      ),
    );
  }
}
