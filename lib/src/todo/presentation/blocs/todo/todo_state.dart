part of 'todo_bloc.dart';

enum TodoStatus {initial, loading, success, failed}

class TodoState extends Equatable {
  final TodoStatus status;
  final TodoSetsModel? data;
  final String errorMessage;

  const TodoState({
    this.status = TodoStatus.initial,
    this.data,
    this.errorMessage = ''
  });

  TodoState copyWith({
    TodoStatus? status,
    TodoSetsModel? data,
    String? errorMessage
  }) => TodoState(
    status: status ?? this.status,
    data: data ?? this.data,
    errorMessage: errorMessage ?? this.errorMessage
  );
  
  @override
  List<Object?> get props => [
    status,
    data,
    errorMessage
  ];
}
