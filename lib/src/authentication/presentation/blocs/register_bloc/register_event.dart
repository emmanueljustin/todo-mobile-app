part of 'register_bloc.dart';

class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class OnRegisterUser extends RegisterEvent {
  final RegistrationParameters params;
  const OnRegisterUser(this.params);

  @override
  List<Object> get props => [
    params,
  ];
}