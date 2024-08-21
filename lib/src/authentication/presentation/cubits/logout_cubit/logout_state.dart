part of 'logout_cubit.dart';

enum LogoutStatus {initial, loading, success, failed}

class LogoutState extends Equatable {
  final LogoutStatus status;

  const LogoutState({
    this.status = LogoutStatus.initial,
  });

  LogoutState copyWith({
    LogoutStatus? status
  }) => LogoutState(
    status: status ?? this.status
  );

  @override
  List<Object> get props => [
    status
  ];
}
