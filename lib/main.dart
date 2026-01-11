import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigation/nav_items.dart';
import 'package:flutter_application_1/widgets/app_bar_custom.dart';
import 'package:flutter_application_1/widgets/app_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: appNavItems[selectedIndex].pageItem.appBarTitle),
      body: appNavItems[selectedIndex].pageItem.page,
      bottomNavigationBar: AppNavigationBar(
        items: appNavItems,
        currentIndex: selectedIndex,
        bottomBarTitle: appNavItems[selectedIndex].pageItem.bottomBarTitle,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
