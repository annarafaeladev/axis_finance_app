

import 'package:axis_finance_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> loginWithGoogle();
  Future<void> logoutWithGoogle();
}
