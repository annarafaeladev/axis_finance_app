import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/page_item.dart';

class NavItem {
  final PageItem pageItem;
  final IconData icon;
  final IconData selectedIcon;
  final bool isDisplayBottomBar;

  const NavItem({
    required this.pageItem,
    required this.icon,
    required this.selectedIcon,
    this.isDisplayBottomBar = false,
  });
}
