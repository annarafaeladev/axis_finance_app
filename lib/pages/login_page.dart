import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injector.dart';
import 'package:flutter_application_1/features/auth/presentation/auth_controller.dart';
import 'package:flutter_application_1/features/finance/presentation/controllers/finance_controller.dart';

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

      await financeController.initFinance();

      Navigator.pushReplacementNamed(context, "/home");
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const Text("Bem-vindo", style: TextStyle(fontSize: 32)),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _login,
                child: const Text("Entrar com Google"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
