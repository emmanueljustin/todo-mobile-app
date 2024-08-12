import 'package:equatable/equatable.dart';

class TodoParams extends Equatable {
  final String? title;
  final String? content;
  final int priorityLevel;
  final bool isFinished;

  const TodoParams({
    this.title,
    this.content,
    required this.priorityLevel,
    required this.isFinished
  });

  @override
  List<Object?> get props => [
    title,
    content,
    priorityLevel,
    isFinished
  ];
}