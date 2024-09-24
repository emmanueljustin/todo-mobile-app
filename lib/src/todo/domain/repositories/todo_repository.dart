import 'package:todoapp/src/todo/data/data_sources/remote_todo_data_source.dart';

import '../../core/parameters/parameters.dart';
import '../../data/models/todo_sets_model.dart';

abstract class TodoRepository {
  final RemoteTodoDataSourceImpl remoteDataSrc;
  TodoRepository(this.remoteDataSrc);

  Future<(String?, TodoSetsModel?)> getAllTodos(PageParams params);
  Future<(String?, bool?)> saveTodos(TodoParams params);
  Future<(String?, bool?)> updateTodo(TodoParams params);
  Future<(String?, bool?)> deleteTodos(List<int> params);
}