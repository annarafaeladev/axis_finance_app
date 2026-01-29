import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:axis_finance_app/navigation/nav_items.dart';
import 'package:axis_finance_app/models/nav_item.dart';
import 'package:axis_finance_app/widgets/common/finance_menu_modal.dart';

class AppNavigationBar extends StatelessWidget {
  final ValueChanged<String> onNavigate;

  const AppNavigationBar({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    final visibleItems = bottomBarNavItems;

    final currentIndex = visibleItems.indexWhere(
      (item) => location.startsWith(item.pageItem.route),
    );

    final selectedNavIndex = currentIndex >= 0
        ? currentIndex
        : visibleItems.length; 

    return NavigationBar(
      selectedIndex: selectedNavIndex,
      onDestinationSelected: (index) async {
        if (index == visibleItems.length) {
          final selected = await showModalBottomSheet<NavItem>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => FinanceMenuModal(items: navItemsModal),
          );

          if (selected != null) {
            onNavigate(selected.pageItem.route);
          }
          return;
        }

        final selectedItem = visibleItems[index];
        onNavigate(selectedItem.pageItem.route);
      },
      destinations: [
        ...visibleItems.map(
          (item) => NavigationDestination(
            selectedIcon: Icon(item.selectedIcon),
            icon: Icon(item.icon),
            label: item.pageItem.bottomBarTitle,
          ),
        ),
        const NavigationDestination(
          selectedIcon: Icon(Icons.more_horiz),
          icon: Icon(Icons.more_horiz),
          label: "Mais",
        ),
      ],
    );
  }
}
