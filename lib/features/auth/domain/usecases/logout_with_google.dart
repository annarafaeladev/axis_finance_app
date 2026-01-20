import 'package:axis_finance_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutWithGoogle {
  final AuthRepository repository;

  LogoutWithGoogle(this.repository);

  Future<void> call() {
    return repository.logoutWithGoogle();
  }
}
