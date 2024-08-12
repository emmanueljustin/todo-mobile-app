import 'package:todoapp/src/todo/data/data_sources/remote_todo_data_source.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';

import '../../core/parameters/parameters.dart';

abstract class TodoRepository {
  final RemoteTodoDataSourceImpl remoteDataSrc;
  TodoRepository(this.remoteDataSrc);

  Future<(String?, List<TodoItemModel>?)> getAllTodos();
  Future<(String?, bool?)> saveTodos(TodoParams params);
}