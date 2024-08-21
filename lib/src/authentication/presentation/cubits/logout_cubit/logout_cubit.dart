import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/src/authentication/domain/usecases/user_logout_usecase.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(const LogoutState());

  final onUserLogout = GetIt.instance<UserLogoutUsecase>();

  void onLogout() {

  }
}
