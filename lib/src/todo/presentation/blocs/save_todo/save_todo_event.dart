part of 'save_todo_bloc.dart';

class SaveTodoEvent extends Equatable {
  const SaveTodoEvent();

  @override
  List<Object> get props => [];
}

class OnSaveTodo extends SaveTodoEvent {
  final TodoParams params;

  const OnSaveTodo(this.params);

  @override
  List<Object> get props => [params];
}