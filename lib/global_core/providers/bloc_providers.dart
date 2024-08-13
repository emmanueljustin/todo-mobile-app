import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/src/todo/presentation/blocs/todo/todo_bloc.dart';

import '../../src/todo/presentation/blocs/delete_todo/delete_todo_bloc.dart';
import '../../src/todo/presentation/blocs/save_todo/save_todo_bloc.dart';
import '../../src/todo/presentation/blocs/update_todo/update_todo_bloc.dart';
import '../../src/todo/presentation/cubits/toggle_finished/toggle_finished_cubit.dart';

class BlocProviders {
  static List<BlocProvider> get() {
    return [
      BlocProvider<TodoBloc>(create: (context) => TodoBloc()),
      BlocProvider<ToggleFinishedCubit>(create: (context) => ToggleFinishedCubit()),
      BlocProvider<SaveTodoBloc>(create: (context) => SaveTodoBloc()),
      BlocProvider<UpdateTodoBloc>(create: (context) => UpdateTodoBloc()),
      BlocProvider<DeleteTodoBloc>(create: (context) => DeleteTodoBloc()),
    ];
  }
}