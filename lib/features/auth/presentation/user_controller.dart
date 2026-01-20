import 'package:axis_finance_app/features/auth/domain/entities/user.dart';
import 'package:axis_finance_app/features/auth/domain/usecases/user_data.dart';


class UserController {
  final UserData _userData;

  UserController(this._userData);

  Future<User?> getUser() async {
    return await _userData();
  }
}
