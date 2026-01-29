import 'package:axis_finance_app/models/nav_item.dart';
import 'package:axis_finance_app/models/page_item.dart';
import 'package:axis_finance_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

const _appNavItems = [
  NavItem(
    pageItem: PageItem(
      route: AppRoutes.home,
      appBarTitle: "Home",
      bottomBarTitle: "Home",
    ),
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: AppRoutes.entries,
      appBarTitle: "Entradas",
      bottomBarTitle: "Entradas",
    ),
    icon: Icons.trending_up_outlined,
    selectedIcon: Icons.trending_up,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: AppRoutes.outs,
      appBarTitle: "Saídas",
      bottomBarTitle: "Saídas",
    ),
    icon: Icons.trending_down_outlined,
    selectedIcon: Icons.trending_down,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: AppRoutes.credit,
      appBarTitle: "Cartão",
      bottomBarTitle: "Cartão",
    ),
    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: AppRoutes.fixed,
      appBarTitle: "Contas Fixas",
      bottomBarTitle: "Fixas",
    ),
    icon: Icons.attach_money,
    selectedIcon: Icons.attach_money,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: AppRoutes.reserve,
      appBarTitle: "Reserva",
      bottomBarTitle: "Reserva",
    ),
    icon: Icons.security,
    selectedIcon: Icons.security,
    isDisplayBottomBar: false, // não aparece na bottom bar
  ),
  NavItem(
    pageItem: PageItem(
      route: AppRoutes.settings,
      appBarTitle: "Configurações",
      bottomBarTitle: "Config",
    ),
    icon: Icons.settings,
    selectedIcon: Icons.settings,
    isDisplayBottomBar: false,
  ),
];

NavItem getCurrentNavItemFromLocation(String location) {
  return _appNavItems.firstWhere(
    (item) => location.startsWith(item.pageItem.route),
    orElse: () => _appNavItems.first,
  );
}

List<NavItem> get bottomBarNavItems =>
    _appNavItems.where((item) => item.isDisplayBottomBar).toList();

List<NavItem> get navItemsModal =>
    _appNavItems.where((item) => !item.isDisplayBottomBar).toList();

int getSelectedBottomIndex(String location) {
  final items = bottomBarNavItems;
  return items.indexWhere(
    (item) => location.startsWith(item.pageItem.route),
  );
}
