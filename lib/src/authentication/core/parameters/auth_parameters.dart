import 'package:equatable/equatable.dart';

class LoginParameters extends Equatable {
  final String email;
  final String password;

  const LoginParameters({
    required this.email,
    required this.password
  });

  @override
  List<Object> get props => [
    email,
    password
  ];
}

class RegistrationParameters extends Equatable {
  final String username;
  final String email;
  final String password;

  const RegistrationParameters({
    required this.username,
    required this.email,
    required this.password
  });

  @override
  List<Object> get props => [
    username,
    email,
    password
  ];
}