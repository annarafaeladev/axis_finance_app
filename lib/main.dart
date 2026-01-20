import 'package:flutter/material.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/navigation/nav_items.dart';
import 'package:axis_finance_app/pages/login_page.dart';
import 'package:axis_finance_app/widgets/app_bar_custom.dart';
import 'package:axis_finance_app/widgets/app_header.dart';
import 'package:axis_finance_app/widgets/app_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance',
      routes: {
        '/': (_) => LoginPage(),
        '/home': (_) => MainLayout(), // sua home
      },
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
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
      appBar: AppBarCustom(
        title: appNavItems[selectedIndex].pageItem.appBarTitle,
      ),
      body: Column(
        children: [
          FinanceHeader(),
          Expanded(child: appNavItems[selectedIndex].pageItem.page),
        ],
      ),

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
