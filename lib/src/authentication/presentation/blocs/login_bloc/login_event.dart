part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class OnLoginStarted extends LoginEvent {
  const OnLoginStarted();

  @override
  List<Object> get props => [];
}

class OnLogin extends LoginEvent {
  final LoginParameters params;
  const OnLogin(this.params);

  @override
  List<Object> get props => [
    params
  ];
}
