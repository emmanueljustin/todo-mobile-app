import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/src/todo/data/data_sources/todo_data_source.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';

import '../../../../global_core/hive_service/hive_methods.dart';
import '../../core/parameters/parameters.dart';

class RemoteTodoDataSourceImpl extends TodoDataSource {
  final Dio _dio = Dio();
  final hiveService = GetIt.instance<HiveMethods>();

  @override
  Future<List<TodoItemModel>> getAllTodos() async {
    final userData = hiveService.getUserData();
    final response = await _dio.get(
      'http://192.168.0.149:8000/api/todos',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userData!.userToken}'
        }
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return ((response.data['data'] ?? []) as List).map((e) => TodoItemModel.fromJson(e)).toList();
    } else {
      throw Exception('Err: status code not ok');
    }
  }

  @override
  Future<bool> saveTodos(TodoParams params) async {
    final userData = hiveService.getUserData();
    final response = await _dio.post('http://192.168.0.149:8000/api/todos', 
        data: {
          'title': params.title,
          'content': params.content,
          'priority_level': params.priorityLevel,
          'is_finished': params.isFinished
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userData!.userToken}'
          }
        ),
      );

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return true;
    } else {
      throw Exception('Err: status code not ok');
    }
  }
  
  @override
  Future<bool> updateTodo(TodoParams params) async {
    final userData = hiveService.getUserData();
    final response = await _dio.put('http://192.168.0.149:8000/api/todos/${params.id}', 
        data: {
          'title': params.title,
          'content': params.content,
          'priority_level': params.priorityLevel,
          'is_finished': params.isFinished
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${userData!.userToken}'
          }
        ),
      );

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return true;
    } else {
      throw Exception('Err: status code not ok');
    }
  }
  
  @override
  Future<bool> deleteTodos(List<int> params) async {
    final userData = hiveService.getUserData();
    final response = await _dio.post('http://192.168.0.149:8000/api/todos/delete_data',
      data: {
        'ids': params,
      },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${userData!.userToken}'
        }
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return true;
    } else {
      throw Exception('Err: status code not ok');
    }
  }
}
