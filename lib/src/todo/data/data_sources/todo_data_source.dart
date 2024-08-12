import 'package:todoapp/src/todo/data/models/todo_item_model.dart';

import '../../core/parameters/parameters.dart';

abstract class TodoDataSource {
  Future<List<TodoItemModel>> getAllTodos();
  Future<bool> saveTodos(TodoParams params);
}