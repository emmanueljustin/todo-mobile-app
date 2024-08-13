part of 'update_todo_bloc.dart';

enum UpdateTodoStatus {initial, loading, success, failed}

class UpdateTodoState extends Equatable {
  final UpdateTodoStatus status;
  final String errorMessage;

  const UpdateTodoState({
    this.status = UpdateTodoStatus.initial,
    this.errorMessage = ''
  });

  UpdateTodoState copyWith({
    UpdateTodoStatus? status,
    String? errorMessage
  }) => UpdateTodoState(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage
  );
  
  @override
  List<Object?> get props => [
    status,
    errorMessage
  ];
}
