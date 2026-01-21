import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/primary_button.dart';

class ContentPageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;
  final Color color;

  const ContentPageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Esquerda: título + descrição
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
        PrimaryButton(
          text: buttonText,
          icon: Icons.add,
          color: color,
          onPressed: onPressed
        ),
      ],
    );
  }
}
