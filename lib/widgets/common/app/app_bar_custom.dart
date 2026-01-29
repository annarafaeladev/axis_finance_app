import 'package:axis_finance_app/models/nav_item.dart';
import 'package:axis_finance_app/navigation/nav_items.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/widgets/common/show_user_menu.dart';
import 'package:go_router/go_router.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    NavItem currentNavItem = getCurrentNavItemFromLocation(location);

    return AppBar(
      forceMaterialTransparency: true,
      elevation: 1,
      title: Row(
        children: [
          Icon(Icons.wallet),
          const SizedBox(width: 8),
          Text(currentNavItem.pageItem.appBarTitle),
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
