import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/data/data_sources/remote_auth_data_source.dart';
import 'package:todoapp/src/authentication/data/models/login_data_model.dart';

abstract class AuthRepository {
  final RemoteAuthDataSourceImpl remoteAuthDataSrc;
  AuthRepository(this.remoteAuthDataSrc);

  Future<(String?, LoginDataModel?)> login(LoginParameters params);
  Future<(String?, bool?)> logout();
  Future<(String?, LoginDataModel?)> register(RegistrationParameters params);
}