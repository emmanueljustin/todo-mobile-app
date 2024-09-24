import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/global_core/hive_service/hive_methods.dart';
import 'package:todoapp/src/authentication/domain/usecases/user_logout_usecase.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(const LogoutState());

  final onUserLogout = GetIt.instance<UserLogoutUsecase>();
  final hiveService = GetIt.instance<HiveMethods>();

  void onLogout() async {
    emit(state.copyWith(status: LogoutStatus.loading));

    final (error, result) = await onUserLogout();

    if (result != null) {
      hiveService.clearBoxes();
      emit(state.copyWith(status: LogoutStatus.success));
    }

    if (error != null) {
      emit(state.copyWith(status: LogoutStatus.failed, errorMessage: error));
    }
  }

  void resetLogoutStatus() {
    emit(state.copyWith(status: LogoutStatus.initial));
  }
}
