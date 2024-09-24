import 'package:todoapp/src/authentication/domain/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.name,
    super.email
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? ''
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'name': name,
    'email': email
  };
}