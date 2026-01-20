import 'package:axis_finance_app/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthDataSource {
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'https://www.googleapis.com/auth/spreadsheets',
      'https://www.googleapis.com/auth/drive.file',
    ],
  );

  Future<UserModel> signIn() async {
    await _googleSignIn.signOut();

    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw Exception('Login cancelado');
    }

    final auth = await account.authentication;
    final token = auth.accessToken;

    if (token == null) {
      throw Exception('Token inválido');
    }

    return UserModel.fromGoogle(account, token);
  }
  
  Future<void> logout() async {
    await _googleSignIn.signOut();

  }
}
