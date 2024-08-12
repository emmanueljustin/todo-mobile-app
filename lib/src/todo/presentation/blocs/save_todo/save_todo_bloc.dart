import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/src/todo/core/parameters/parameters.dart';
import 'package:todoapp/src/todo/domain/usecases/save_todo_usecase.dart';

part 'save_todo_event.dart';
part 'save_todo_state.dart';

class SaveTodoBloc extends Bloc<SaveTodoEvent, SaveTodoState> {
  SaveTodoBloc() : super(const SaveTodoState()) {
    on<OnSaveTodo>(_onSaveTodo);
  }

  final _saveTodos = GetIt.instance<SaveTodoUsecase>();

  FutureOr<void> _onSaveTodo(
      OnSaveTodo event, Emitter<SaveTodoState> emit) async {
    emit(state.copyWith(status: SaveTodoStatus.loading));

    final (error, data) = await _saveTodos(event.params);

    if (data != null) {
      emit(state.copyWith(status: SaveTodoStatus.success));
    }
    if (error != null) {
      emit(state.copyWith(status: SaveTodoStatus.failed));
    }
  }
}
