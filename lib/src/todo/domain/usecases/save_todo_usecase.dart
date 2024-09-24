import 'package:todoapp/global_core/usecases/usecase_with_params.dart';

import '../../core/parameters/parameters.dart';
import '../repositories/todo_repository.dart';

class SaveTodoUsecase extends UseCaseWithParams<bool, TodoParams>{
  final TodoRepository _todoRepository;
  SaveTodoUsecase(this._todoRepository);

  @override
  Future<(String?, bool?)> call(TodoParams params) {
    return _todoRepository.saveTodos(params);
  }
  
}