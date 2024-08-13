import 'package:todoapp/global_core/usecases/usecase_with_params.dart';
import 'package:todoapp/src/todo/core/parameters/parameters.dart';

import '../repositories/todo_repository.dart';

class UpdateTodoUsecase extends UseCaseWithParams<bool, TodoParams>{
  final TodoRepository _todoRepository;
  UpdateTodoUsecase(this._todoRepository);

  @override
  Future<(String?, bool?)> call(TodoParams params) {
    return _todoRepository.updateTodo(params);
  }
}