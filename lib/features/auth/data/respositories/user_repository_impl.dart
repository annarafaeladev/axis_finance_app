import 'package:axis_finance_app/core/storage/local_storage.dart';
import 'package:axis_finance_app/core/storage/storage_key.dart';
import 'package:axis_finance_app/features/auth/data/models/user_model.dart';
import 'package:axis_finance_app/features/auth/domain/entities/user.dart';
import 'package:axis_finance_app/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalStorage storage;

  UserRepositoryImpl(this.storage);

  @override
  Future<User?> getUser() async {
    final json = await storage.getMap(StorageKey.user);
    if (json == null) return null;

    final model = UserModel.fromJson(json);
    return model;
  }
}
