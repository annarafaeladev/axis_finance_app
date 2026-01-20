import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/show_user_menu.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white, // remove o tom do Material 3
      elevation: 0,
      title: Row(
        children: [
          Icon(Icons.account_balance_wallet, color: Color(0xFF10B981)),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => showUserMenu(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
