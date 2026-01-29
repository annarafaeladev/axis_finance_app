import 'package:axis_finance_app/core/routes/app_router.dart';
import 'package:axis_finance_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/widgets/common/app/app_bar_custom.dart';
import 'package:axis_finance_app/widgets/common/app/app_header.dart';
import 'package:axis_finance_app/widgets/common/app/app_navigation_bar.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Finance',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData.dark(useMaterial3: true),
    );
  }
}

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      appBar: AppBarCustom(),
      body: Column(
        children: [
          FinanceHeader(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: AppNavigationBar(
        onNavigate: (route) => context.go(route),
      ),
    );
  }
}
