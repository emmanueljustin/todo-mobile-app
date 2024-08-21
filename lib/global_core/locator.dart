import 'package:get_it/get_it.dart';
import 'package:todoapp/global_core/hive_service/hive_methods.dart';
import 'package:todoapp/src/authentication/data/data_sources/remote_auth_data_source.dart';
import 'package:todoapp/src/authentication/data/repositories/auth_repository_impl.dart';
import 'package:todoapp/src/authentication/domain/repositories/auth_repository.dart';
import 'package:todoapp/src/authentication/domain/usecases/user_login_usecase.dart';
import 'package:todoapp/src/todo/data/data_sources/remote_todo_data_source.dart';
import 'package:todoapp/src/todo/data/repositories/todo_repository_impl.dart';
import 'package:todoapp/src/todo/domain/repositories/todo_repository.dart';

import '../src/authentication/domain/usecases/user_logout_usecase.dart';
import '../src/todo/domain/usecases/delete_todos_usecase.dart';
import '../src/todo/domain/usecases/get_all_todos_usecase.dart';
import '../src/todo/domain/usecases/save_todo_usecase.dart';
import '../src/todo/domain/usecases/update_todo_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  _setUpTodoModules();
  _setupAuthModules();

  // Hive
  getIt.registerLazySingleton<HiveMethods>(() => HiveMethods());
}

void _setUpTodoModules() {
  // Data Sources
  getIt.registerLazySingleton<RemoteTodoDataSourceImpl>(() => RemoteTodoDataSourceImpl());

  // Repositories
  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(getIt()));
  
  // Usecases
  getIt.registerLazySingleton<GetAllTodosUsecase>(() => GetAllTodosUsecase(getIt()));
  getIt.registerLazySingleton<SaveTodoUsecase>(() => SaveTodoUsecase(getIt()));
  getIt.registerLazySingleton<UpdateTodoUsecase>(() => UpdateTodoUsecase(getIt()));
  getIt.registerLazySingleton<DeleteTodosUsecase>(() => DeleteTodosUsecase(getIt()));
}

void _setupAuthModules() {
  // Data Sources
  getIt.registerLazySingleton<RemoteAuthDataSourceImpl>(() => RemoteAuthDataSourceImpl());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));

  //Usecases
  getIt.registerLazySingleton<UserLoginUsecase>(() => UserLoginUsecase(getIt()));
  getIt.registerLazySingleton<UserLogoutUsecase>(() => UserLogoutUsecase(getIt()));
}