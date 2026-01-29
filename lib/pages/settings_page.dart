import 'package:axis_finance_app/core/routes/app_routes.dart';
import 'package:axis_finance_app/core/theme/app_colors.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:axis_finance_app/core/di/injector.dart';

import 'package:axis_finance_app/widgets/common/app/app_button.dart';
import 'package:axis_finance_app/widgets/common/app/app_card_content.dart';
import 'package:axis_finance_app/widgets/common/app/app_scaffold_page.dart';
import 'package:axis_finance_app/widgets/settings/finance_settings_form.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final FinanceSettingsController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = getIt<FinanceSettingsController>();
    // controller.init();

    
    // TODO: utlizar o provider para entregar os dados para a PAGE 
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Campos obrigatórios não preenchidos"),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    ;

    final essenciais = int.parse(controller.essenciaisController.text);
    final qualidade = int.parse(controller.qualidadeController.text);
    final futuro = int.parse(controller.futuroController.text);

    if (essenciais + qualidade + futuro != 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("A soma dos percentuais deve ser 100%"),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    controller.saveSettings();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Configurações salva com sucesso"),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return AppScaffoldPage(
          title: "Configurações",
          leadingIcon: Icons.arrow_back,
          onLeadingPressed: () => context.go(AppRoutes.home),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CommonCardContent(
                    child: FinanceSettingsForm(controller: controller),
                  ),
                  const SizedBox(height: 24),
                  AppButton(label: "Salvar", onPressed: _save),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
