import 'package:flutter/material.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_settings_controller.dart';

class FinanceSettingsForm extends StatelessWidget {
  final FinanceSettingsController controller;

  const FinanceSettingsForm({super.key, required this.controller});

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

        TextFormField(
          controller: controller.rendaController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "Renda mensal *",
            prefixText: "R\$ ",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Informe sua renda mensal";
            }

            final renda = double.tryParse(value.replaceAll(',', '.'));
            if (renda == null || renda <= 0) {
              return "Digite um valor válido maior que zero";
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        _PercentField(
          label: "Porcentagem destinada a Essenciais (%) *",
          controller: controller.essenciaisController,
        ),

        const SizedBox(height: 16),

        _PercentField(
          label: "Porcentagem destinada a Qualidade (%) *",
          controller: controller.qualidadeController,
        ),

        const SizedBox(height: 16),

        _PercentField(
          label: "Porcentagem destinada ao Futuro (%) *",
          controller: controller.futuroController,
        ),

        const SizedBox(height: 16),

        _DayField(
          label: "Dia de Fechamento do cartão *",
          controller: controller.fechamentoController,
        ),

        const SizedBox(height: 16),

        _DayField(
          label: "Dia de Vencimento do cartão *",
          controller: controller.vencimentoController,
        ),
      ],
    );
  }
}

class _PercentField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _PercentField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        suffixText: "%",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Campo obrigatório";
        }

        final percent = int.tryParse(value);
        if (percent == null) {
          return "Digite um número válido";
        }

        if (percent < 0 || percent > 100) {
          return "Use um valor entre 0 e 100";
        }

        return null;
      },
    );
  }
}


class _DayField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _DayField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: "Dia",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Campo obrigatório";
        }

        final day = int.tryParse(value);
        if (day == null) {
          return "Digite um número válido";
        }

        if (day < 1 || day > 31) {
          return "Dia deve estar entre 1 e 31";
        }

        return null;
      },
    );
  }
}

