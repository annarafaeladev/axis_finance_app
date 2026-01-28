import 'package:axis_finance_app/widgets/common/app/app_button.dart';
import 'package:axis_finance_app/widgets/common/app/app_card_content.dart';
import 'package:axis_finance_app/widgets/common/app/app_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/settings/finance_settings_form.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldPage(
      title: "Configuracões",
      leadingIcon: Icons.arrow_back,
      onLeadingPressed: () => context.go('/home'),
      actionIcon: Icons.settings,
      onActionPressed: () => {},
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonCardContent(child: FinanceSettingsForm()),

            const SizedBox(height: 24),

            AppButton(label: "Salvar", onPressed: () => {}),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
