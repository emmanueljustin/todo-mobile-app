import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/global_core/hive_service/hive_methods.dart';
import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/data/data_sources/auth_data_source.dart';
import 'package:todoapp/src/authentication/data/models/login_data_model.dart';

class RemoteAuthDataSourceImpl extends AuthDataSource {
  final Dio _dio = Dio();
  final hiveService = GetIt.instance<HiveMethods>();

  @override
  Future<LoginDataModel> login(LoginParameters params) async {
    final response = await _dio.post('https://wordpress-1336469-4897237.cloudwaysapps.com/api/auth/login',
      data: {
        'email': params.email,
        'password': params.password,
      },
      options: Options(
        headers: {
          'Accept': 'application/json'
        }
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return LoginDataModel.fromJson(response.data);
    } else {
      throw Exception('Err: status code not ok');
    }
  }
  
  @override
  Future<bool> logout() async {
    final userData = hiveService.getUserData();
    final response = await _dio.post('https://wordpress-1336469-4897237.cloudwaysapps.com/api/auth/logout',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userData!.userToken}'
        }
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return true;
    } else {
      throw Exception('Err: status code not ok');
    }
  }
  
  @override
  Future<LoginDataModel> register(RegistrationParameters params) async {
    final response = await _dio.post('https://wordpress-1336469-4897237.cloudwaysapps.com/api/auth/register',
      data: {
        'name': params.username,
        'email': params.email,
        'password': params.password,
      },
      options: Options(
        headers: {
          'Accept': 'application/json'
        }
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return LoginDataModel.fromJson(response.data);
    } else {
      throw Exception('Err: status code not ok');
    }
  }
}