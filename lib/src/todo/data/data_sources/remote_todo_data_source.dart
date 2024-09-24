import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/src/todo/data/data_sources/todo_data_source.dart';

import '../../../../global_core/hive_service/hive_methods.dart';
import '../../core/parameters/parameters.dart';
import '../models/todo_sets_model.dart';

class RemoteTodoDataSourceImpl extends TodoDataSource {
  final Dio _dio = Dio();
  final hiveService = GetIt.instance<HiveMethods>();

  @override
  Future<TodoSetsModel> getAllTodos(PageParams params) async {
    final data = hiveService.getUserData();
    final response = await _dio.post('https://wordpress-1336469-4897237.cloudwaysapps.com/api/todos/specific-all',
    data: {
      'ownerId': data!.userData.id,
      'pageView': params.pageView,
      'itemsPerPage': params.itemsPerPage
    },
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${data.userToken}'
        }
      ),
    );

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return TodoSetsModel.fromJson(response.data['data']);
    } else {
      throw Exception('Err: status code not ok');
    }
  }

  @override
  Future<bool> saveTodos(TodoParams params) async {
    final data = hiveService.getUserData();
    final response = await _dio.post('https://wordpress-1336469-4897237.cloudwaysapps.com/api/todos', 
        data: {
          'owner_id': data!.userData.id,
          'title': params.title,
          'content': params.content,
          'priority_level': params.priorityLevel,
          'is_finished': params.isFinished
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${data.userToken}'
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
    final response = await _dio.put('https://wordpress-1336469-4897237.cloudwaysapps.com/api/todos/${params.id}', 
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
    final response = await _dio.post('https://wordpress-1336469-4897237.cloudwaysapps.com/api/todos/delete_data',
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
