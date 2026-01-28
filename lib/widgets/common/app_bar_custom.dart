import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/common/show_user_menu.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      elevation: 1,
      title: Row(
        children: [
          Icon(Icons.wallet),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.account_circle_rounded),
          onPressed: () => showUserMenu(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
