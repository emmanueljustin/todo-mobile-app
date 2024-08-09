import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/src/todo/presentation/blocs/todo/todo_bloc.dart';

class BlocProviders {
  static List<BlocProvider> get() {
    return [
      BlocProvider<TodoBloc>(create: (context) => TodoBloc()),
    ];
  }
}