import 'package:dio/dio.dart';
import 'package:todoapp/src/todo/domain/repositories/todo_repository.dart';

import '../../core/parameters/parameters.dart';
import '../models/todo_sets_model.dart';

class TodoRepositoryImpl extends TodoRepository {
  TodoRepositoryImpl(super.remoteDataSrc);

  @override
  Future<(String?, TodoSetsModel?)> getAllTodos(PageParams params) async {
    try {
      final data = await remoteDataSrc.getAllTodos(params);
      return (null, data);
    } on DioException catch (dio) {
      return (dio.message, null);
    } catch (e) {
      return ("Oops! Server has encountered an issue.", null);
    }
  }
  
  @override
  Future<(String?, bool?)> saveTodos(TodoParams params) async {
    try {
      final data = await remoteDataSrc.saveTodos(params);
      return (null, data);
    } on DioException catch (dio) {
      return (dio.message, null);
    } catch (e) {
      return ("Oops! Server has encountered an issue.", null);
    }
  }
  
  @override
  Future<(String?, bool?)> updateTodo(TodoParams params) async {
    try {
      final data = await remoteDataSrc.updateTodo(params);
      return (null, data);
    } on DioException catch (dio) {
      return (dio.message, null);
    } catch (e) {
      return ("Oops! Server has encountered an issue.", null);
    }
  }
  
  @override
  Future<(String?, bool?)> deleteTodos(List<int> params) async {
    try {
      final data = await remoteDataSrc.deleteTodos(params);
      return (null, data);
    } on DioException catch (dio) {
      return (dio.message, null);
    } catch (e) {
      return ("Oops! Server has encountered an issue.", null);
    }
  }
}