import 'package:todoapp/global_core/usecases/usecase_with_params.dart';
import 'package:todoapp/src/todo/core/parameters/parameters.dart';
import 'package:todoapp/src/todo/domain/repositories/todo_repository.dart';

import '../../data/models/todo_sets_model.dart';

class GetAllTodosUsecase extends UseCaseWithParams<TodoSetsModel, PageParams> {
  final TodoRepository _todoRepository;
  GetAllTodosUsecase(this._todoRepository);

  @override
  Future<(String?, TodoSetsModel?)> call(PageParams params) {
    return _todoRepository.getAllTodos(params);
  }

}