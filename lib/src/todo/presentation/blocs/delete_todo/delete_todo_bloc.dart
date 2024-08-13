import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/src/todo/domain/usecases/delete_todos_usecase.dart';

part 'delete_todo_event.dart';
part 'delete_todo_state.dart';

class DeleteTodoBloc extends Bloc<DeleteTodoEvent, DeleteTodoState> {
  DeleteTodoBloc() : super(const DeleteTodoState()) {
    on<OnDeleteTodo>(_onDeleteTodo);
  }

  final _deleteTodos = GetIt.instance<DeleteTodosUsecase>();

  FutureOr<void> _onDeleteTodo(OnDeleteTodo event, Emitter<DeleteTodoState> emit) async {
    emit(state.copyWith(status: DeleteTodoStatus.loading));

    final (error, data) = await _deleteTodos(event.params);

    if (data != null) {
      emit(state.copyWith(status: DeleteTodoStatus.success, successMessage: 'The data is deleted succesfully.'));
    }

    if (error != null) {
      emit(state.copyWith(status: DeleteTodoStatus.failed, errorMessage: error));
    }
  }
}
