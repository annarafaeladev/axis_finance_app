import 'package:flutter/material.dart';

class AppScaffoldPage extends StatelessWidget {
  final String title;
  final Widget body;

  /// 🔙 LEADING (default: voltar)
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;

  /// ⭐ ACTION (opcional)
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;

  final bool centerTitle;

  const AppScaffoldPage({
    super.key,
    required this.title,
    required this.body,
    this.leadingIcon,
    this.onLeadingPressed,
    this.actionIcon,
    this.onActionPressed,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(title),
        centerTitle: centerTitle,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        /// 🔙 BOTÃO LEADING PADRÃO
        leading: leadingIcon == null && onLeadingPressed == null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.maybePop(context),
              )
            : leadingIcon != null
                ? IconButton(
                    icon: Icon(leadingIcon),
                    onPressed: onLeadingPressed,
                  )
                : null,

        /// ⭐ ACTION OPCIONAL
        actions: actionIcon != null
            ? [
                IconButton(
                  icon: Icon(actionIcon),
                  onPressed: onActionPressed,
                )
              ]
            : null,
      ),
      body: SafeArea(child: body),
    );
  }
}
