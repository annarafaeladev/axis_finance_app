import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/content_page_header.dart';
import 'package:flutter_application_1/widgets/finance_card.dart';

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
            color: Color.fromARGB(255, 14, 160, 68),
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
            startColor: Color(0xFFEF4444),
            endColor: Color(0xFFF87171),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
