import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/content_page_header.dart';
import 'package:flutter_application_1/widgets/finance_settings_form.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FinanceSettingsForm()
        ],
      ),
    );
  }
}
