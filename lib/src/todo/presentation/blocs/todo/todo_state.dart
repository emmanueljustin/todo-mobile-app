part of 'todo_bloc.dart';

enum TodoStatus {initial, loading, success, failed}

class TodoState extends Equatable {
  final TodoStatus status;

  const TodoState({
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({
    TodoStatus? status
  }) => TodoState(
    status: status ?? this.status
  );
  
  @override
  List<Object> get props => [
    status
  ];
}
