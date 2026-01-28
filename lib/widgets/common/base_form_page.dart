import 'package:axis_finance_app/core/theme/app_colors.dart';
import 'package:axis_finance_app/widgets/common/app_button.dart';
import 'package:axis_finance_app/widgets/common/app_card_content.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () => isEditing ? onDelete?.call() : onSave(),
            icon: isEditing
                ? Icon(Icons.delete)
                : Icon(Icons.add_circle_outline),
            color: isEditing ? AppColors.error : AppColors.primary,
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
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
      ),
    );
  }
}
