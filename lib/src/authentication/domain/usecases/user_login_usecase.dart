import 'package:todoapp/global_core/usecases/usecase_with_params.dart';
import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/data/models/login_data_model.dart';
import 'package:todoapp/src/authentication/domain/repositories/auth_repository.dart';

class UserLoginUsecase extends UseCaseWithParams<LoginDataModel, LoginParameters>{
  final AuthRepository _authRepository;
  UserLoginUsecase(this._authRepository);
  
  @override
  Future<(String?, LoginDataModel?)> call(LoginParameters params) {
    return _authRepository.login(params);
  }
}