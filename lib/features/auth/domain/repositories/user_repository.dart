

import 'package:axis_finance_app/features/auth/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getUser();
}
