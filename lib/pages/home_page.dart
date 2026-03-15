import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_controller.dart';
import '../widgets/common/finance_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceController>(
      builder: (context, controller, _) {
        final totalEntradas = controller.getTotalEntry();
        final totalSaidas = controller.getTotalSaidas();
        final totalSaldo = controller.getTotalSaldo();

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

              FinanceCard(
                title: "Total Entradas",
                value: totalEntradas,
                icon: Icons.trending_up,
                startColor: Color(0xFF189E5D),
                endColor: Color(0xFF2EC985),
              ),

              const SizedBox(height: 16),

              FinanceCard(
                title: "Total de Gastos",
                value: totalSaidas,
                icon: Icons.trending_down,
                startColor: Color(0xFFDD2B2B),
                endColor: Color(0xFFE95C38),
              ),

              const SizedBox(height: 16),

              FinanceCard(
                title: "Saldo",
                value: totalSaldo,
                icon: Icons.account_balance_wallet,
                startColor: Color(0xFF16A28C),
                endColor: Color(0xFF1FADAD),
              ),

              const SizedBox(height: 16),

              const FinanceCard(
                title: "Reserva",
                value: "R\$ 0,00",
                icon: Icons.savings,
                startColor: Color(0xFF3D82F8),
                endColor: Color(0xFF6673F8),
              ),
            ],
          ),
        );
      },
    );
  }
}
