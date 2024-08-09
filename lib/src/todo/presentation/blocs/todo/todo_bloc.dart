import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoStarted>(_onStarted);
    on<TodoFetchAll>(_onFetchAll);
  }

  FutureOr<void> _onStarted(TodoStarted event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.initial));
  }

  FutureOr<void> _onFetchAll(TodoFetchAll event, Emitter<TodoState> emit) async {
  }
}
