import 'package:axis_finance_app/core/routes/app_router.dart';
import 'package:axis_finance_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/widgets/common/app/app_bar_custom.dart';
import 'package:axis_finance_app/widgets/common/app/app_header.dart';
import 'package:axis_finance_app/widgets/common/app/app_navigation_bar.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

import 'features/finance/presentation/controllers/finance_controller.dart';
import 'features/finance/presentation/controllers/finance_settings_controller.dart';
import 'features/finance/presentation/controllers/finance_entry_controller.dart';
import 'features/finance/presentation/controllers/finance_expense_controller.dart';
import 'features/finance/presentation/controllers/finance_fixed_expense_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  runApp(
    MultiProvider(
      providers: [
        /// Controller principal da Home (saldo, totais etc)
        ChangeNotifierProvider(
          create: (_) => getIt<FinanceController>()..initControllers(),
        ),

        /// Configurações (renda mensal, percentuais, datas)
        ChangeNotifierProvider(
          create: (_) => getIt<FinanceSettingsController>(),
        ),

        /// Entradas
        ChangeNotifierProvider(create: (_) => getIt<FinanceEntryController>()),

        /// Despesas variáveis
        ChangeNotifierProvider(
          create: (_) => getIt<FinanceExpenseController>(),
        ),

        /// Despesas fixas
        ChangeNotifierProvider(
          create: (_) => getIt<FinanceFixedExpenseController>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
