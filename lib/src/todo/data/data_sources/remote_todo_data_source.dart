import 'package:dio/dio.dart';
import 'package:todoapp/src/todo/data/data_sources/todo_data_source.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';

class RemoteTodoDataSourceImpl extends TodoDataSource {

  final Dio _dio = Dio();

  @override
  Future<List<TodoItemModel>> getAllTodos() async {
    final response = await _dio.get('http://192.168.0.149:8000/api/todos');

    if (response.statusCode == 200) {
      if (response.data['status'] == 'err') {
        throw Exception(response.data['message']);
      }
      return (response.data['data'] as List).map((e) => TodoItemModel.fromJson(e)).toList();
    } else {
      throw Exception('Err: status code not ok');
    }
  }
}