import 'package:todoapp/src/todo/domain/entities/todo_item.dart';

class TodoItemModel extends TodoItem {
  const TodoItemModel({
    super.id,
    super.title,
    super.content,
    super.priorityLevel = 1,
    super.isFinished = false
  });

  factory TodoItemModel.fromJson(Map<String, dynamic> json) {
    return TodoItemModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      priorityLevel: json['priority_level'] ?? 1,
      isFinished: json['is_finished'] ?? false
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "priority_level": priorityLevel,
    "is_finished": isFinished
  };
}