import 'package:equatable/equatable.dart';
import 'package:todoapp/src/authentication/data/models/user_data_model.dart';

class LoginData extends Equatable {
  final String userToken;
  final UserDataModel userData;

  const LoginData({
    this.userToken = '',
    this.userData = const UserDataModel()
  });

  @override
  List<Object> get props => [
    userToken,
    userData
  ];
}