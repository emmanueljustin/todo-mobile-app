part of 'todo_bloc.dart';

class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoStarted extends TodoEvent {
  const TodoStarted();

  @override
  List<Object> get props => [];
}

class TodoInitFetch extends TodoEvent {
  const TodoInitFetch();

  @override
  List<Object> get props => [];
}
