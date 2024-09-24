import 'package:todoapp/src/todo/data/models/todo_sets_model.dart';

import '../../core/parameters/parameters.dart';

abstract class TodoDataSource {
  Future<TodoSetsModel> getAllTodos(PageParams params);
  Future<bool> saveTodos(TodoParams params);
  Future<bool> updateTodo(TodoParams params);
  Future<bool> deleteTodos(List<int> params);
}