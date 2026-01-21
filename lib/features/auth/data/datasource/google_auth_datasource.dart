import 'package:axis_finance_app/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthDataSource {
  final GoogleSignIn googleSignIn;
  GoogleAuthDataSource(this.googleSignIn);

  Future<UserModel> signIn() async {
    GoogleSignInAccount? account = await googleSignIn.signInSilently();

    account ??= await googleSignIn.signIn();

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
    await googleSignIn.signOut();
  }
}
