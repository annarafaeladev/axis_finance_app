import 'package:axis_finance_app/models/nav_item.dart';
import 'package:axis_finance_app/models/page_item.dart';
import 'package:flutter/material.dart';

const appNavItems = [
  NavItem(
    pageItem: PageItem(
      route: '/home',
      appBarTitle: "Home",
      bottomBarTitle: "Home",
    ),
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: '/entries',
      appBarTitle: "Entradas",
      bottomBarTitle: "Entradas",
    ),
    icon: Icons.trending_up_outlined,
    selectedIcon: Icons.trending_up,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: '/outs',
      appBarTitle: "Saídas",
      bottomBarTitle: "Saídas",
    ),
    icon: Icons.trending_down_outlined,
    selectedIcon: Icons.trending_down,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: '/credit',
      appBarTitle: "Cartão",
      bottomBarTitle: "Cartão",
    ),
    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: '/fixed',
      appBarTitle: "Contas Fixas",
      bottomBarTitle: "Fixas",
    ),
    icon: Icons.attach_money,
    selectedIcon: Icons.attach_money,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      route: '/reserve',
      appBarTitle: "Reserva",
      bottomBarTitle: "Reserva",
    ),
    icon: Icons.security,
    selectedIcon: Icons.security,
    isDisplayBottomBar: false, // não aparece na bottom bar
  ),
  NavItem(
    pageItem: PageItem(
      route: '/settings',
      appBarTitle: "Configurações",
      bottomBarTitle: "Config",
    ),
    icon: Icons.settings,
    selectedIcon: Icons.settings,
    isDisplayBottomBar: false,
  ),
];
