import 'package:axis_finance_app/core/storage/local_storage.dart';
import 'package:axis_finance_app/features/auth/data/datasource/google_auth_datasource.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleAuthDataSource google;
  final LocalStorage storage;

  AuthRepositoryImpl(this.google, this.storage);

  @override
  Future<User> loginWithGoogle() async {
    final user = await google.signIn();
    await storage.saveMap('user', user.toJson());
    return user;
  }
  
  @override
  Future<void> logoutWithGoogle() async {
    await google.logout();
    await storage.delete('user');
  }

  
}
