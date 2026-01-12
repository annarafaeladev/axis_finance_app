import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/nav_item.dart';
import 'package:flutter_application_1/widgets/finance_menu_modal.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex;
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

    return NavigationBar(
      //   selectedIndex: items[currentIndex].isDisplayBottomBar
      // ? visibleItems.indexOf(items[currentIndex])
      // : -1,
      selectedIndex: currentIndex,
      onDestinationSelected: (index) async {
        // Clicou no botão "Mais"
        if (index == visibleItems.length) {
          final selected = await showModalBottomSheet<NavItem>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => FinanceMenuModal(items: hiddenItems),
          );

          if (selected != null) {
            final realIndex = items.indexOf(selected);
            onTap(realIndex); // navega corretamente
          }
          return;
        }

        // Clique normal
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

        // Botão "Mais"
        const NavigationDestination(
          selectedIcon: Icon(Icons.more_horiz),
          icon: Icon(Icons.more_horiz),
          label: "Mais",
        ),
      ],
    );
  }
}
