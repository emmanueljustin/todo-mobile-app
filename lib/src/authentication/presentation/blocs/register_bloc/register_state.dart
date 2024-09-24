part of 'register_bloc.dart';

enum RegistrationStatus {initial, loading, success, failed}

class RegisterState extends Equatable {
  final RegistrationStatus status;
  final LoginDataModel data;
  final String errorMessage;

  const RegisterState({
    this.status = RegistrationStatus.initial,
    this.data = const LoginDataModel(),
    this.errorMessage = '',
  });

  RegisterState copyWith({
    RegistrationStatus? status,
    LoginDataModel? data,
    String? errorMessage,
  }) => RegisterState(
    status: status ?? this.status,
    data: data ?? this.data,
    errorMessage: errorMessage ?? this.errorMessage,
  );
  
  @override
  List<Object> get props => [
    status,
    data,
    errorMessage,
  ];
}
