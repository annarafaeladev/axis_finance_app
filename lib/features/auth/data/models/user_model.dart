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
    id: json['id'],
    name: json['name'],
    email: json['email'],
    photo: json['photo'],
    accessToken: json['accessToken'],
  );
}



  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photo': photo,
        'accessToken': accessToken,
      };
}
