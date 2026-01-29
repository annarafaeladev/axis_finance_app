import 'package:axis_finance_app/features/finance/domain/entities/entrada.dart';
import 'package:axis_finance_app/features/finance/domain/entities/fixa.dart';
import 'package:axis_finance_app/features/finance/domain/entities/saida.dart';
import 'package:axis_finance_app/main.dart';
import 'package:axis_finance_app/pages/credit_card_page.dart';
import 'package:axis_finance_app/pages/entries/entry_form_page.dart';
import 'package:axis_finance_app/pages/entries/finance_in_page.dart';
import 'package:axis_finance_app/pages/finance_reserve_page.dart';
import 'package:axis_finance_app/pages/fixed/finance_fixed_page.dart';
import 'package:axis_finance_app/pages/fixed/fixe_form_page.dart';
import 'package:axis_finance_app/pages/home_page.dart';
import 'package:axis_finance_app/pages/login_page.dart';
import 'package:axis_finance_app/pages/outs/expense_form_page.dart';
import 'package:axis_finance_app/pages/outs/finance_out_page.dart';
import 'package:axis_finance_app/pages/settings_page.dart';
import 'package:axis_finance_app/pages/spash.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';



final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.root,
  routes: [
    GoRoute(
      path: AppRoutes.root,
      builder: (_, __) => const AuthCheckPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (_, __) => const SettingsPage(),
    ),
    GoRoute(
      path: AppRoutes.reserve,
      builder: (_, __) => const FinanceReservePage(),
    ),
    GoRoute(
      path: AppRoutes.entryForm,
      builder: (context, state) {
        final entry = state.extra as Entrada?;
        return EntradaFormPage(entry: entry);
      },
    ),
    GoRoute(
      path: AppRoutes.outForm,
      builder: (context, state) {
        final out = state.extra as Saida?;
        return SaidaFormPage(item: out);
      },
    ),
    GoRoute(
      path: AppRoutes.fixedForm,
      builder: (context, state) {
        final item = state.extra as Fixa?;
        return FixaFormPage(item: item);
      },
    ),

    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (_, __) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.entries,
          builder: (_, __) => const FinanceInPage(),
        ),
        GoRoute(
          path: AppRoutes.outs,
          builder: (_, __) => const FinanceOutPage(),
        ),
        GoRoute(
          path: AppRoutes.fixed,
          builder: (_, __) => const FinanceFixedPage(),
        ),
        GoRoute(
          path: AppRoutes.credit,
          builder: (_, __) => const CreditCardPage(),
        ),
      ],
    ),
  ],
);

const Map<String, int> _routeIndexMap = {
  AppRoutes.home: 0,
  AppRoutes.entries: 1,
  AppRoutes.outs: 2,
  AppRoutes.credit: 3,
  AppRoutes.fixed: 4,
};

int locationToTabIndex(String location) {
  for (final entry in _routeIndexMap.entries) {
    if (location.startsWith(entry.key)) return entry.value;
  }
  return 0;
}
