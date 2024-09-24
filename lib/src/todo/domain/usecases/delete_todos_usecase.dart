import 'package:todoapp/global_core/usecases/usecase_with_params.dart';

import '../repositories/todo_repository.dart';

class DeleteTodosUsecase extends UseCaseWithParams<bool, List<int>>{
  final TodoRepository _todoRepository;
  DeleteTodosUsecase(this._todoRepository);
  
  @override
  Future<(String?, bool?)> call(List<int> params) {
    return _todoRepository.deleteTodos(params);
  }
}