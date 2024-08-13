import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/src/todo/core/parameters/parameters.dart';
import 'package:todoapp/src/todo/domain/usecases/update_todo_usecase.dart';

part 'update_todo_event.dart';
part 'update_todo_state.dart';

class UpdateTodoBloc extends Bloc<UpdateTodoEvent, UpdateTodoState> {
  UpdateTodoBloc() : super(const UpdateTodoState()) {
    on<OnUpdateTodo>(_onUpdateTodo);
  }

  final _updateTodo = GetIt.instance<UpdateTodoUsecase>();

  FutureOr<void> _onUpdateTodo(OnUpdateTodo event, Emitter<UpdateTodoState> emit) async {
    emit(state.copyWith(status: UpdateTodoStatus.loading));

    final (error, data) = await _updateTodo(event.todo);

    if (data != null) {
      emit(state.copyWith(status: UpdateTodoStatus.success));
    }

    if (error != null) {
      emit(state.copyWith(status: UpdateTodoStatus.failed, errorMessage: error));
    }
  }
}
