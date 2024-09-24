part of 'logout_cubit.dart';

enum LogoutStatus {initial, loading, success, failed}

class LogoutState extends Equatable {
  final LogoutStatus status;
  final String errorMessage;

  const LogoutState({
    this.status = LogoutStatus.initial,
    this.errorMessage = ''
  });

  LogoutState copyWith({
    LogoutStatus? status,
    String? errorMessage
  }) => LogoutState(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage
  );

  @override
  List<Object> get props => [
    status,
    errorMessage
  ];
}
