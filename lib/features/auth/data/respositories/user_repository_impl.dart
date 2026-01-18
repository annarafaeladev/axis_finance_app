import 'package:flutter_application_1/core/storage/local_storage.dart';
import 'package:flutter_application_1/features/auth/data/models/user_model.dart';
import 'package:flutter_application_1/features/auth/domain/entities/user.dart';
import 'package:flutter_application_1/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalStorage storage;

  UserRepositoryImpl(this.storage);

  @override
  Future<User?> getUser() async {
    final json = await storage.getMap('user');
    if (json == null) return null;

    final model = UserModel.fromJson(json);
    return model;
  }
}
