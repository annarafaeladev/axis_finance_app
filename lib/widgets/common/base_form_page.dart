import 'package:axis_finance_app/widgets/common/app_button.dart';
import 'package:axis_finance_app/widgets/common/app_card_content.dart';
import 'package:axis_finance_app/widgets/common/app_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseFormPage extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback? onDelete;
  final bool isEditing;
  final String saveLabel;

  const BaseFormPage({
    super.key,
    required this.title,
    required this.child,
    required this.onSave,
    this.onDelete,
    this.isEditing = false,
    this.saveLabel = 'Salvar',
  });

  @override
  Widget build(BuildContext context) {
    void cancel() {
      Navigator.pop(context);
    }

    return AppScaffoldPage(
      title: title,
      leadingIcon: Icons.arrow_back,
      onLeadingPressed: () => context.pop(),
      actionIcon: isEditing ? Icons.delete : Icons.add_circle_outline,
      onActionPressed: isEditing ? onDelete : onSave,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonCardContent(child: child),

            const SizedBox(height: 24),

            AppButton(label: saveLabel, onPressed: onSave),

            if (isEditing && onDelete != null) ...[
              const SizedBox(height: 12),

              AppButton(
                label: "Cancelar",
                onPressed: cancel,
                type: AppButtonType.danger,
              ),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
