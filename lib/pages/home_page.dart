import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_controller.dart';
import 'package:flutter/material.dart';
import '../widgets/finance_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final FinanceController _financeController;
  String _totalEntradas = 'R\$ 0,00';

  @override
  void initState() {
    super.initState();
    _financeController = getIt<FinanceController>();
    _totalEntradas = _financeController.getTotalEntry();
  }

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
          FinanceCard(
            title: "Total Entradas",
            value: _totalEntradas,
            icon: Icons.trending_up,
            startColor: Color(0xFF189E5D),
            endColor: Color(0xFF2EC985),
          ),

          const SizedBox(height: 16),

          // 🔴 Total de Gastos
          const FinanceCard(
            title: "Total de Gastos",
            value: "R\$ 0,00",
            icon: Icons.trending_down,
            startColor: Color(0xFFDD2B2B),
            endColor: Color(0xFFE95C38),
          ),

          const SizedBox(height: 16),
          // 🟢 Saldo
          const FinanceCard(
            title: "Saldo",
            value: "R\$ 0.000,00",
            icon: Icons.account_balance_wallet,
            startColor: Color(0xFF16A28C),
            endColor: Color(0xFF1FADAD),
          ),

          const SizedBox(height: 16),

          // 🔵 Reserva
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
  }

}
