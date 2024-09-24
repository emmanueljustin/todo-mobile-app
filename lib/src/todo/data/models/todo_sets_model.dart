import 'package:todoapp/src/todo/data/models/page_model.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';
import 'package:todoapp/src/todo/domain/entities/todo_sets.dart';

class TodoSetsModel extends TodoSets {
  const TodoSetsModel({
    super.todoItems = const [],
    super.pageData
  });

  TodoSetsModel copyWith({
    List<TodoItemModel>? todoItems,
    PageModel? pageData
  }) => TodoSetsModel(
    todoItems: todoItems ?? this.todoItems,
    pageData: pageData ?? this.pageData
  );

  factory TodoSetsModel.fromJson(Map<String, dynamic> json) {
    return TodoSetsModel(
      todoItems: ((json['todo_items'] ?? []) as List).map((e) => TodoItemModel.fromJson(e)).toList(),
      pageData: PageModel.fromJson(json['page_data']),
    );
  }

  Map<String, dynamic> toJson() => {
    "todo_items": todoItems,
    "page_data": pageData
  };
}