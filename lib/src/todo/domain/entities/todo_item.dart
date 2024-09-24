import 'package:equatable/equatable.dart';

class TodoItem extends Equatable {
  final int id;
  final int ownerId;
  final String? title;
  final String? content;
  final int priorityLevel;
  final bool isFinished;

  const TodoItem({
    required this.id,
    required this.ownerId,
    this.title,
    this.content,
    required this.priorityLevel,
    required this.isFinished
  });

  @override
  List<Object?> get props => [
    id,
    ownerId,
    title,
    content,
    priorityLevel,
    isFinished
  ];
}