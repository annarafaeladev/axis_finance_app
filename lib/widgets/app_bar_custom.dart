import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.black, // remove o tom do Material 3
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.account_balance_wallet),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_active),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}