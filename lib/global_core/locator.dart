import 'package:get_it/get_it.dart';
import 'package:todoapp/src/todo/data/data_sources/remote_todo_data_source.dart';
import 'package:todoapp/src/todo/data/repositories/todo_repository_impl.dart';
import 'package:todoapp/src/todo/domain/repositories/todo_repository.dart';

import '../src/todo/domain/usecases/get_all_todos_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  _setUpTodoModules();
}

void _setUpTodoModules() {
  // Data Sources
  getIt.registerLazySingleton<RemoteTodoDataSourceImpl>(() => RemoteTodoDataSourceImpl());

  // Repositories
  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(getIt()));
  
  // Usecases
  getIt.registerLazySingleton<GetAllTodosUsecase>(() => GetAllTodosUsecase(getIt()));
}