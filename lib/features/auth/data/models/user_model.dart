import 'package:axis_finance_app/core/storage/storage_key.dart';
import 'package:axis_finance_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.photo,
    required super.accessToken,
  });

  factory UserModel.fromGoogle(account, String token) {
    return UserModel(
      id: account.id,
      name: account.displayName ?? '',
      email: account.email,
      photo: account.photoUrl,
      accessToken: token,
    );
  }

    factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[StorageKeyUser.id.key],
      name: json[StorageKeyUser.name.key],
      email: json[StorageKeyUser.email.key],
      photo: json[StorageKeyUser.photo.key],
      accessToken: json[StorageKeyUser.accessToken.key],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      StorageKeyUser.id.key: id,
      StorageKeyUser.name.key: name,
      StorageKeyUser.email.key: email,
      StorageKeyUser.photo.key: photo,
      StorageKeyUser.accessToken.key: accessToken,
    };
  }
}
