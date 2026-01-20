import 'package:axis_finance_app/features/auth/domain/entities/user.dart';
import 'package:axis_finance_app/features/auth/domain/repositories/user_repository.dart';

class UserData {
  final UserRepository repository;

  UserData(this.repository);

  Future<User?> call() {
    return repository.getUser();
  }
}
