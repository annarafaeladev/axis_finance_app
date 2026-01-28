import 'package:axis_finance_app/core/theme/app_colors.dart';
import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/pages/credit_card_page.dart';
import 'package:axis_finance_app/pages/fixed/finance_fixed_page.dart';
import 'package:axis_finance_app/pages/entries/finance_in_page.dart';
import 'package:axis_finance_app/pages/outs/finance_out_page.dart';
import 'package:axis_finance_app/pages/finance_reserve_page.dart';
import 'package:axis_finance_app/pages/home_page.dart';
import 'package:axis_finance_app/pages/settings_page.dart';
import 'package:axis_finance_app/pages/spash.dart';
import 'package:axis_finance_app/pages/entries/entry_form_page.dart';
import 'package:axis_finance_app/pages/outs/expense_form_page.dart';
import 'package:axis_finance_app/pages/fixed/fixe_form_page.dart';
import 'package:flutter/material.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/navigation/nav_items.dart';
import 'package:axis_finance_app/pages/login_page.dart';
import 'package:axis_finance_app/widgets/common/app/app_bar_custom.dart';
import 'package:axis_finance_app/widgets/common/app/app_header.dart';
import 'package:axis_finance_app/widgets/common/app/app_navigation_bar.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthCheckPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(path: '/reserve', builder: (_, __) => const FinanceReservePage()),
    GoRoute(
      path: '/entries/form',
      builder: (context, state) {
        final entry = state.extra as Entrada?;
        return EntradaFormPage(entry: entry);
      },
    ),
    GoRoute(
      path: '/outs/form',
      builder: (context, state) {
        final out = state.extra as Saida?;
        return SaidaFormPage(item: out);
      },
    ),
    GoRoute(
      path: '/fixed/form',
      builder: (context, state) {
        final item = state.extra as Fixa?;
        return FixaFormPage(item: item);
      },
    ),

    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomePage()),
        GoRoute(path: '/entries', builder: (_, __) => const FinanceInPage()),
        GoRoute(path: '/outs', builder: (_, __) => const FinanceOutPage()),
        GoRoute(path: '/fixed', builder: (_, __) => const FinanceFixedPage()),
        GoRoute(path: '/credit', builder: (_, __) => const CreditCardPage()),
      ],
    ),
  ],
);

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
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData.dark(useMaterial3: true),
    );
  }
}

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  int _locationToIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/entries')) return 1;
    if (location.startsWith('/outs')) return 2;
    if (location.startsWith('/fixed')) return 4;
    if (location.startsWith('/credit')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _locationToIndex(location);
    final currentItem = appNavItems[selectedIndex];

    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      appBar: AppBarCustom(title: currentItem.pageItem.appBarTitle),
      body: Column(
        children: [
          FinanceHeader(),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: AppNavigationBar(
        items: appNavItems,
        currentIndex: selectedIndex,
        bottomBarTitle: currentItem.pageItem.bottomBarTitle,
        onTap: (index) {
          context.go(appNavItems[index].pageItem.route);
        },
      ),
    );
  }
}
