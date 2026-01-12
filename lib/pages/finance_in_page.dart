import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/content_page_header.dart';
import 'package:flutter_application_1/widgets/finance_card.dart';

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
            color: Color.fromARGB(255, 14, 160, 68),
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
            startColor: Color(0xFF22C55E),
            endColor: Color(0xFF4ADE80),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
