import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/global_core/hive_service/hive_methods.dart';
import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/data/models/login_data_model.dart';
import 'package:todoapp/src/authentication/domain/usecases/user_register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<OnRegisterUser>(_onRegisterUser);
  }

  final onUserRegister = GetIt.instance<UserRegisterUsecase>();
  final hiveService = GetIt.instance<HiveMethods>();

  FutureOr<void> _onRegisterUser(OnRegisterUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: RegistrationStatus.loading));

    final (error, data) = await onUserRegister(event.params);

    if (data != null) {
      hiveService.setUserData(data);
      emit(state.copyWith(status: RegistrationStatus.success, data: data));
    }

    if (error != null) {
      emit(state.copyWith(status: RegistrationStatus.failed, errorMessage: error));
    }
  }
}
