import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/finance_fixed_page.dart';
import 'package:flutter_application_1/pages/finance_out_page.dart';
import '../models/nav_item.dart';
import '../models/page_item.dart';
import '../pages/home_page.dart';
import '../pages/finance_in_page.dart';
import '../pages/credit_card_page.dart';
import '../pages/settings_page.dart';

const appNavItems = [
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Home",
      page: HomePage(),
      bottomBarTitle: "Home",
    ),
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    isDisplayBottomBar: true,
  ),
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Entradas",
      page: FinanceInPage(),
      bottomBarTitle: "Entradas",
    ),
    isDisplayBottomBar: true,
    icon: Icons.trending_up_outlined,
    selectedIcon: Icons.trending_up,
  ),
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Saídas",
      page: FinanceOutPage(),
      bottomBarTitle: "Saídas",
    ),
    isDisplayBottomBar: true,
    icon: Icons.trending_down_outlined,
    selectedIcon: Icons.trending_down,
  ),
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Contas Fixa",
      page: FinanceFixedPage(),
      bottomBarTitle: "Contas Fixa",
    ),

    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card,
  ),
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Cartão",
      page: CreditCardPage(),
      bottomBarTitle: "Cartão",
    ),
    isDisplayBottomBar: true,
    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card,
  ),
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Investimentos",
      page: CreditCardPage(),
      bottomBarTitle: "Investimentos",
    ),

    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card,
  ),
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Reserva",
      page: CreditCardPage(),
      bottomBarTitle: "Reserva",
    ),

    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card,
  ),
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Relatórios",
      page: CreditCardPage(),
      bottomBarTitle: "Relatórios",
    ),

    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card,
  ),
  NavItem(
    pageItem: PageItem(
      appBarTitle: "Configurações",
      page: SettingsPage(),
      bottomBarTitle: "Configurações",
    ),
    icon: Icons.more_horiz,
    selectedIcon: Icons.more_horiz,
  ),
];
