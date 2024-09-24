part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, failed }
enum LazyLoadStatus { initial, loading, success, failed }

class TodoState extends Equatable {
  final TodoStatus status;
  final LazyLoadStatus lazyStatus;
  final TodoSetsModel data;
  final String errorMessage;
  final String lazyLoadMessage;

  const TodoState({
    this.status = TodoStatus.initial,
    this.lazyStatus = LazyLoadStatus.initial,
    this.data = const TodoSetsModel(),
    this.errorMessage = '',
    this.lazyLoadMessage = ''
  });

  TodoState copyWith({
    TodoStatus? status,
    LazyLoadStatus? lazyStatus,
    TodoSetsModel? data,
    String? errorMessage,
    String? lazyLoadMessage
  }) => TodoState(
    status: status ?? this.status,
    lazyStatus: lazyStatus ?? this.lazyStatus,
    data: data ?? this.data,
    errorMessage: errorMessage ?? this.errorMessage,
    lazyLoadMessage: lazyLoadMessage ?? this.lazyLoadMessage
  );
  
  @override
  List<Object?> get props => [
    status,
    lazyStatus,
    data,
    errorMessage,
    lazyLoadMessage
  ];
}
