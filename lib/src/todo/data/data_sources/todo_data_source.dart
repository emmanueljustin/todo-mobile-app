import 'package:todoapp/src/todo/data/models/todo_item_model.dart';

abstract class TodoDataSource {
  Future<List<TodoItemModel>> getAllTodos();
}