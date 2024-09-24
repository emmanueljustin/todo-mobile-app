import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/global_core/hive_service/hive_methods.dart';
import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/data/models/login_data_model.dart';
import 'package:todoapp/src/authentication/domain/usecases/user_login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<OnLoginStarted>(_onLoginStarted);
    on<OnLogin>(_onLogin);
    on<LogoutTrigger>(_onLogoutTrigger);
  }

  final onUserLogin = GetIt.instance<UserLoginUsecase>();
  final hiveService = GetIt.instance<HiveMethods>();

  FutureOr<void> _onLoginStarted(OnLoginStarted event, Emitter<LoginState> emit) async {
    final userData = hiveService.getUserData();

    if (userData != null) {
      emit(state.copyWith(status: LoginStatus.success, data: userData));
    } else {
      emit(state.copyWith(status: LoginStatus.initial));
    }
  }

  FutureOr<void> _onLogin(OnLogin event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final (error, data) = await onUserLogin(event.params);

    if (data != null) {
      hiveService.setUserData(data);
      emit(state.copyWith(status: LoginStatus.success, data: data));
      log('::: <> This is ok');
    }

    if (error != null) {
      emit(state.copyWith(status: LoginStatus.failed, errorMessage: error));
      log('::: <> This is NOT ok');
    }
  }

  FutureOr<void> _onLogoutTrigger(LogoutTrigger event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.initial, data: const LoginDataModel()));
    log('::: <> ${state.status}');
  }
}
