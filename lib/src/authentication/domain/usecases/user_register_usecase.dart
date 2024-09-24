import 'package:todoapp/global_core/usecases/usecase_with_params.dart';
import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/data/models/login_data_model.dart';
import 'package:todoapp/src/authentication/domain/repositories/auth_repository.dart';

class UserRegisterUsecase extends UseCaseWithParams<LoginDataModel, RegistrationParameters> {
  final AuthRepository _authRepository;
  UserRegisterUsecase(this._authRepository);

  @override
  Future<(String?, LoginDataModel?)> call(RegistrationParameters params) {
    return _authRepository.register(params);
  }
}