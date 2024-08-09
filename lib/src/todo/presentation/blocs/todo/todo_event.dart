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

class TodoFetchAll extends TodoEvent {

  const TodoFetchAll();
  @override
  List<Object> get props => [];
}
