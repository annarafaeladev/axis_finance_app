import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final account = await _googleSignIn.signIn();

      if (account == null) return; // usuário cancelou

      final auth = await account.authentication;
      final accessToken = auth.accessToken;

      if (accessToken == null) {
        throw Exception('Falha ao obter accessToken');
      }

      // Aqui você já tem o token OAuth real
      print('Access Token: $accessToken');

      // Depois você pode navegar para o app
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao logar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              const Text(
                'Bem-vindo',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Entre com sua conta Google para acessar suas planilhas e arquivos.',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () => _handleSignIn(context),
                  // icon: Image.asset(
                  //   'assets/google.png',
                  //   height: 24,
                  // ),
                  label: const Text(
                    'Entrar com Google',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ), 
      ),
    );
  }
}
                                      