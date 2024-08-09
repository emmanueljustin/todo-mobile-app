import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';
import 'package:todoapp/src/todo/domain/usecases/get_all_todos_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoStarted>(_onStarted);
    on<TodoFetchAll>(_onFetchAll);
  }

  final _fetchAllTodos = GetIt.instance<GetAllTodosUsecase>();

  FutureOr<void> _onStarted(TodoStarted event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.initial));
  }

  FutureOr<void> _onFetchAll(TodoFetchAll event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    final (error, data) = await _fetchAllTodos();

    if (data != null) {
      emit(state.copyWith(status: TodoStatus.success, data: data));
    }

    if (error != null) {
      emit(state.copyWith(status: TodoStatus.failed, errorMessage: error));
    }
  }
}
