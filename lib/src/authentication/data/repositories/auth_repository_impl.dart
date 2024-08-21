import 'package:dio/dio.dart';
import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/data/models/login_Data_model.dart';
import 'package:todoapp/src/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(super.remoteAuthDataSrc);

  @override
  Future<(String?, LoginDataModel?)> login(LoginParameters params) async {
    try {
      final data = await remoteAuthDataSrc.login(params);
      return (null, data);
    } on DioException catch (dio) {
      return (dio.message, null);
    } catch (e) {
      return ("Oops! Server has encountered an issue.", null);
    }
  }
  
  @override
  Future<(String?, bool?)> logout() async {
    try {
      final data = await remoteAuthDataSrc.logout();
      return (null, data);
    } on DioException catch (dio) {
      return (dio.message, null);
    } catch (e) {
      return ("Oops! Server has encountered an issue.", null);
    }
  }
}