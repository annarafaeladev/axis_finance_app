import 'package:flutter/material.dart';
import 'package:axis_finance_app/models/nav_item.dart';
import 'package:axis_finance_app/widgets/common/finance_menu_modal.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex; // índice REAL dentro de appNavItems
  final List<NavItem> items;
  final String bottomBarTitle;
  final ValueChanged<int> onTap;

  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.bottomBarTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final visibleItems = items.where((i) => i.isDisplayBottomBar).toList();
    final hiddenItems = items.where((i) => !i.isDisplayBottomBar).toList();

    final currentItem = items[currentIndex];

    // Se a rota atual não estiver na bottom bar, seleciona o botão "Mais"
    final selectedNavIndex = currentItem.isDisplayBottomBar
        ? visibleItems.indexOf(currentItem)
        : visibleItems.length;

    return NavigationBar(
      selectedIndex: selectedNavIndex,

      onDestinationSelected: (index) async {
        if (index == visibleItems.length) {
          final selected = await showModalBottomSheet<NavItem>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => FinanceMenuModal(items: hiddenItems),
          );

          if (selected != null) {
            final realIndex = items.indexOf(selected);
            onTap(realIndex);
          }
          return;
        }
        final selectedItem = visibleItems[index];
        final realIndex = items.indexOf(selectedItem);
        onTap(realIndex);
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
