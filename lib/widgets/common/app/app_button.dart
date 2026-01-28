import 'package:flutter/material.dart';
import 'package:axis_finance_app/core/theme/app_colors.dart';

enum AppButtonType { primary, outline, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final double height;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.height = 48,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;
    BorderSide? border;

    switch (type) {
      case AppButtonType.primary:
        background = AppColors.primary;
        foreground = AppColors.foregroundColor;
        break;

      case AppButtonType.outline:
        background = AppColors.foregroundColor;
        foreground = AppColors.primary;
        border = BorderSide(color: AppColors.primary);
        break;

      case AppButtonType.danger:
        background = AppColors.foregroundColor;
        foreground = AppColors.error;
        border = BorderSide(color: AppColors.error);
        break;
    }

    return SizedBox(
      height: height,
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          elevation: 0,
          side: border,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

