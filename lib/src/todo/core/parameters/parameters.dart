import 'package:equatable/equatable.dart';

class TodoParams extends Equatable {
  final int? id;
  final String? title;
  final String? content;
  final int priorityLevel;
  final bool isFinished;

  const TodoParams({
    this.id,
    this.title,
    this.content,
    required this.priorityLevel,
    required this.isFinished
  });

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    priorityLevel,
    isFinished
  ];
}

class PageParams extends Equatable {
  final int pageView;
  final int itemsPerPage;

  const PageParams({
    required this.pageView,
    required this.itemsPerPage
  });

  @override
  List<Object> get props => [
    pageView,
    itemsPerPage
  ];
}