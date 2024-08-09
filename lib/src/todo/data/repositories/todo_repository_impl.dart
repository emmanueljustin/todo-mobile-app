import 'package:dio/dio.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';
import 'package:todoapp/src/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  TodoRepositoryImpl(super.remoteDataSrc);

  @override
  Future<(String?, List<TodoItemModel>?)> getAllTodos() async {
    try {
      final data = await remoteDataSrc.getAllTodos();
      return (null, data);
    } on DioException catch (dio) {
      return (dio.message, null);
    } catch (e) {
      return ("It Didn't Work", null);
    }
  }
}