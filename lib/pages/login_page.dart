import 'package:axis_finance_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/auth/presentation/auth_controller.dart';
import 'package:axis_finance_app/features/finance/presentation/controllers/finance_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController controller = getIt<AuthController>();
  final FinanceController financeController = getIt<FinanceController>();

  Future<void> _login() async {
    try {
      await controller.login();

      await financeController.init();

      context.go(AppRoutes.home);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),

              // Logo ou ícone do app
              Image.asset(
                'assets/image/logo_app.png',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 24),

              Text('Bem-vindo', style: theme.textTheme.headlineMedium),

              const SizedBox(height: 8),

              Text(
                'Faça login para continuar',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 48),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: SignInButton(
                  Buttons.google,
                  text: 'Entrar com Google',
                  elevation: 2,
                  loadingIndicatorColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: _login,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Ao continuar, você concorda com nossos termos de uso.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const Spacer(),

              Text(
                '© 2026 • Axis App',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
