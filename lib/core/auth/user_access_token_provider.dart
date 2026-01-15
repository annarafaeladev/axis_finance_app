import 'package:flutter_application_1/core/auth/access_token_provider.dart';
import 'package:flutter_application_1/features/auth/domain/usecases/user_data.dart';

class UserAccessTokenProvider implements AccessTokenProvider {
  final UserData userData;

  UserAccessTokenProvider(this.userData);

  @override
  Future<String> getAccessToken() async {
    final user = await userData();

    if (user == null) {
      throw Exception('Usuário não logado');
    }

    return user.accessToken;
  }
}
