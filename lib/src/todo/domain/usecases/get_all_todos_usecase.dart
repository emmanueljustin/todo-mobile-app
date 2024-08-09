import 'package:todoapp/global_core/usecases/usecase_with_no_params.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';
import 'package:todoapp/src/todo/domain/repositories/todo_repository.dart';

class GetAllTodosUsecase extends UseCaseWithNoParams<List<TodoItemModel>> {
  final TodoRepository _todoRepository;
  GetAllTodosUsecase(this._todoRepository);
  
  @override
  Future<(String?, List<TodoItemModel>?)> call() {
    return _todoRepository.getAllTodos();
  }
}