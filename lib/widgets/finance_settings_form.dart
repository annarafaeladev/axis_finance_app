import 'package:flutter/material.dart';

class FinanceSettingsForm extends StatelessWidget {
  const FinanceSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              "Renda e Percentuais",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Configure sua renda mensal e a distribuição (ex: 50 / 30 / 20)",
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 20),

            // Renda mensal
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Renda mensal",
                prefixText: "R\$ ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Percentuais
            Row(
              children: [
                Expanded(child: _PercentField(label: "Essencial (%)")),
                const SizedBox(width: 12),
                Expanded(child: _PercentField(label: "Qualidade (%)")),
                const SizedBox(width: 12),
                Expanded(child: _PercentField(label: "Futuro (%)")),
              ],
            ),

            const SizedBox(height: 20),

            // Datas do cartão
            Row(
              children: [
                Expanded(child: _DayField(label: "Fechamento")),
                const SizedBox(width: 12),
                Expanded(child: _DayField(label: "Vencimento")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PercentField extends StatelessWidget {
  final String label;

  const _PercentField({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: "%",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}

class _DayField extends StatelessWidget {
  final String label;

  const _DayField({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: "Dia",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
