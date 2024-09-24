part of 'update_todo_bloc.dart';

class UpdateTodoEvent extends Equatable {
  const UpdateTodoEvent();

  @override
  List<Object> get props => [];
}

class OnUpdateTodo extends UpdateTodoEvent {
  final TodoParams todo;
  const OnUpdateTodo(this.todo);

  @override
  List<Object> get props => [
    todo
  ];
}
