part of 'delete_todo_bloc.dart';

enum DeleteTodoStatus {initial, loading, success, failed}

class DeleteTodoState extends Equatable {
  final DeleteTodoStatus status;
  final String successMessage;
  final String errorMessage;

  const DeleteTodoState({
    this.status = DeleteTodoStatus.initial,
    this.successMessage = '',
    this.errorMessage = ''
  });

  DeleteTodoState copyWith({
    DeleteTodoStatus? status,
    String? successMessage,
    String? errorMessage
  }) => DeleteTodoState(
    status: status ?? this.status,
    successMessage: successMessage ?? this.successMessage,
    errorMessage: errorMessage ?? this.errorMessage
  );
  
  @override
  List<Object> get props => [
    status,
    successMessage,
    errorMessage
  ];
}
