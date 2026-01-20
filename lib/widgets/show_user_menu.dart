import 'package:flutter/material.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/features/auth/presentation/auth_controller.dart';
import 'package:axis_finance_app/features/auth/presentation/user_controller.dart';

Future<void> showUserMenu(BuildContext context) async {
  final userController = getIt<UserController>();
  final authController = getIt<AuthController>();

  final user = await userController.getUser();

  if (user == null) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    return;
  }

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user.photo != null
                  ? NetworkImage(user.photo!)
                  : null,
              child: user.photo == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            const SizedBox(height: 12),
            Text(
              user.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(user.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () async {
                await authController.logoutWithGoogle();
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
            ),
          ],
        ),
      );
    },
  );
}
