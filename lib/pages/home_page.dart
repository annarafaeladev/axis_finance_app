import 'package:flutter/material.dart';
import '../widgets/finance_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Visão geral das suas finanças",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 20),

          // 🟢 Renda Mensal
          const FinanceCard(
            title: "Renda Mensal",
            value: "R\$ 0.000,00",
            icon: Icons.trending_up,
            startColor: Color(0xFF22C55E),
            endColor: Color(0xFF4ADE80),
          ),

          const SizedBox(height: 16),

          // 🔴 Total de Gastos
          const FinanceCard(
            title: "Total de Gastos",
            value: "R\$ 0,00",
            icon: Icons.trending_down,
            startColor: Color(0xFFEF4444),
            endColor: Color(0xFFF87171),
          ),

          const SizedBox(height: 16),
          // 🟢 Saldo
          const FinanceCard(
            title: "Saldo",
            value: "R\$ 0.000,00",
            icon: Icons.account_balance_wallet,
            startColor: Color(0xFF16A085),
            endColor: Color(0xFF1ABC9C),
          ),

          const SizedBox(height: 16),

          // 🔵 Reserva
          const FinanceCard(
            title: "Reserva",
            value: "R\$ 0,00",
            icon: Icons.savings,
            startColor: Color(0xFF3B82F6),
            endColor: Color(0xFF60A5FA),
          ),
        ],
      ),
    );
  }
}
