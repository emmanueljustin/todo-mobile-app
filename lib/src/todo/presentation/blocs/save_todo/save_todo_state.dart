part of 'save_todo_bloc.dart';

enum SaveTodoStatus {initial, loading, success, failed}

class SaveTodoState extends Equatable {
  final SaveTodoStatus status;
  final String errorMessage;

  const SaveTodoState({
    this.status = SaveTodoStatus.initial,
    this.errorMessage = ''
  });

  SaveTodoState copyWith({
    SaveTodoStatus? status,
    String? errorMessage
  }) => SaveTodoState(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage
  );
  
  @override
  List<Object?> get props => [
    status,
    errorMessage
  ];
}
