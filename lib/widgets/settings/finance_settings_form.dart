import 'package:flutter/material.dart';

class FinanceSettingsForm extends StatelessWidget {
  const FinanceSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        _PercentField(label: "Porcentagem destido a Essencial (%)"),

        const SizedBox(height: 16),

        _PercentField(label: "Porcentagem destido a Qualidade (%)"),

        const SizedBox(height: 16),

        _PercentField(label: "Porcentagem destido a Futuro (%)"),

        // Datas do cartão
        const SizedBox(height: 16),

        _DayField(label: "Dia Fechamento cartão"),
        const SizedBox(height: 16),
        _DayField(label: "Dia Vencimento cartão"),
      ],
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
