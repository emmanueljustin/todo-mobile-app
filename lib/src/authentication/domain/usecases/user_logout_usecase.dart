import 'package:todoapp/global_core/usecases/usecase_with_no_params.dart';
import 'package:todoapp/src/authentication/domain/repositories/auth_repository.dart';

class UserLogoutUsecase extends UseCaseWithNoParams<bool> {
  final AuthRepository _authRepository;
  UserLogoutUsecase(this._authRepository);

  @override
  Future<(String?, bool?)> call() {
    return _authRepository.logout();
  }
}