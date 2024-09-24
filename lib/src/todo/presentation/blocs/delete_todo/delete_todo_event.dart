part of 'delete_todo_bloc.dart';

class DeleteTodoEvent extends Equatable {
  const DeleteTodoEvent();

  @override
  List<Object> get props => [];
}

class OnDeleteTodo extends DeleteTodoEvent {
  final List<int> params;
  const OnDeleteTodo(this.params);

  @override
  List<Object> get props => [
    params,
  ];
}