import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/data/models/login_Data_model.dart';

abstract class AuthDataSource {
  Future<LoginDataModel> login(LoginParameters params);
  Future<bool> logout();
}