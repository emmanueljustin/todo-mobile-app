import 'package:todoapp/src/authentication/data/models/user_data_model.dart';
import 'package:todoapp/src/authentication/domain/entities/login_data.dart';

class LoginDataModel extends LoginData {
  const LoginDataModel({
    super.userToken,
    super.userData
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      userToken: json['user_token'] ?? '',
      userData: UserDataModel.fromJson(json['user_data'])
    );
  }

  Map<String, dynamic> toJson() => {
    'user_token': userToken,
    'user_data': userData
  };
}