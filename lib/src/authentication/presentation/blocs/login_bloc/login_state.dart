part of 'login_bloc.dart';

enum LoginStatus {initial, loading, success, failed}

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginDataModel data;
  final String errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.data = const LoginDataModel(),
    this.errorMessage = ''
  });

  LoginState copyWith({
    LoginStatus? status,
    LoginDataModel? data,
    String? errorMessage,
  }) => LoginState(
    status: status ?? this.status,
    data: data ?? this.data,
    errorMessage: errorMessage ?? this.errorMessage
  );
  
  @override
  List<Object> get props => [
    status,
    data,
    errorMessage
  ];
}
