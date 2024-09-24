import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/src/todo/core/parameters/parameters.dart';
import 'package:todoapp/src/todo/domain/usecases/get_all_todos_usecase.dart';

import '../../../data/models/todo_item_model.dart';
import '../../../data/models/todo_sets_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<TodoStarted>(_onStarted);
    on<TodoInitFetch>(_onInitFetch);
    on<TodoPageNav>(_onTodoPageNav);
  }

  final _fetchAllTodos = GetIt.instance<GetAllTodosUsecase>();

  final int itemsPerPage = 8;

  FutureOr<void> _onStarted(TodoStarted event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.initial, lazyStatus: LazyLoadStatus.initial));
  }

  FutureOr<void> _onInitFetch(TodoInitFetch event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));

    final (error, data) = await _fetchAllTodos(PageParams(pageView: 1, itemsPerPage: itemsPerPage));

    if (data != null) {
      emit(state.copyWith(status: TodoStatus.success, data: data));
    }

    if (error != null) {
      emit(state.copyWith(status: TodoStatus.failed, errorMessage: error));
    }
  }

  FutureOr<void> _onTodoPageNav(TodoPageNav event, Emitter<TodoState> emit) async {
    final List<TodoItemModel> tmpList = [...state.data.todoItems];
    emit(state.copyWith(lazyStatus: LazyLoadStatus.loading));

    if (state.data.pageData!.nextPage != null) {
      final (error, data) = await _fetchAllTodos(PageParams(pageView: state.data.pageData!.nextPage!, itemsPerPage: itemsPerPage));

      if (data != null) {
        for (TodoItemModel items in data.todoItems) {
          tmpList.add(items);
        }
        emit(state.copyWith(lazyStatus: LazyLoadStatus.success, data: data.copyWith(todoItems: tmpList)));
      }

      if (error != null) {
        emit(state.copyWith(lazyStatus: LazyLoadStatus.failed, errorMessage: error));
      }
    } else {
      emit(state.copyWith(lazyStatus: LazyLoadStatus.initial, lazyLoadMessage: 'There no more items to show'));
    }
  }
}
