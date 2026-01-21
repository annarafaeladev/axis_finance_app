import 'package:axis_finance_app/core/auth/access_token_provider.dart';
import 'package:axis_finance_app/core/auth/session_manager.dart';
import 'package:axis_finance_app/core/di/injector.dart';
import 'package:axis_finance_app/main.dart';
import 'package:axis_finance_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  AuthCheckPageState createState() => AuthCheckPageState();
}

class AuthCheckPageState extends State<AuthCheckPage> {
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();
  final AccessTokenProvider _tokenProvider = getIt<AccessTokenProvider>();

  var logo = 'assets/image/logo_app.png';
  bool _loading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

Future<void> _checkLogin() async {
  try {
    final account = await _googleSignIn.signInSilently();
    String? token = await _tokenProvider.getAccessToken();

    await Future.delayed(const Duration(seconds: 3));

    if (account == null && token != null) {
      await _tokenProvider.clear();
      token = null;
    }

    if (!mounted) return;

    setState(() {
      _isLoggedIn = account != null && token != null;
      _loading = false;
    });
  } finally {
    getIt<SessionManager>().unlockRedirect();
  }
}


  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(logo, width: 120, height: 120),
              const SizedBox(height: 24),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    return _isLoggedIn ? MainLayout() : LoginPage();
  }
}
