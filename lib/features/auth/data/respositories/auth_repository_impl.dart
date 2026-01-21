import 'package:axis_finance_app/core/storage/local_storage.dart';
import 'package:axis_finance_app/core/storage/storage_key.dart';
import 'package:axis_finance_app/features/auth/data/datasource/google_auth_datasource.dart';
import 'package:axis_finance_app/features/auth/domain/entities/user.dart';
import 'package:axis_finance_app/features/auth/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final GoogleAuthDataSource google;
  final LocalStorage storage;

  AuthRepositoryImpl(this.google, this.storage);

  @override
  Future<User> loginWithGoogle() async {
    final user = await google.signIn();
    await storage.saveMap(StorageKey.user, user.toJson());
    return user;
  }

  @override
  Future<void> logoutWithGoogle() async {
    await google.logout();
    await storage.delete(StorageKey.user);
    await storage.delete(StorageKey.spreadsheetId);
  }
}
