import 'package:equatable/equatable.dart';
import 'package:todoapp/src/todo/data/models/page_model.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';

class TodoSets extends Equatable {
  final List<TodoItemModel> todoItems;
  final PageModel? pageData;

  const TodoSets({
    required this.todoItems,
    this.pageData
  });

  @override
  List<Object?> get props => [
    todoItems,
    pageData
  ];
}