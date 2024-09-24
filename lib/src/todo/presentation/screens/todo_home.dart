import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todoapp/src/authentication/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:todoapp/src/authentication/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:todoapp/src/todo/presentation/blocs/todo/todo_bloc.dart';
import 'package:todoapp/src/todo/presentation/cubits/multi_selector/multi_selector_cubit.dart';
import 'package:todoapp/src/todo/presentation/screens/add_edit_todo_screen.dart';

// import '../../../authentication/presentation/screens/login_screen.dart';
import '../blocs/delete_todo/delete_todo_bloc.dart';

class TodoHome extends StatelessWidget {
  const TodoHome({super.key});

  Widget errorMessage(BuildContext context, TodoState todoState) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          const Icon(
            Icons.report_gmailerrorred,
            color: Colors.red,
            size: 200,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            todoState.errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            '''We are currently trying to fix the issue. We will get right back to you thank you for your patience''',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () => context.read<TodoBloc>().add(const TodoInitFetch()),
            child: const Text('Reload'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<TodoBloc>(context, listen: false)..add(const TodoInitFetch()),
        ),
        // BlocProvider<TodoBloc>(
        //   create: (context) => TodoBloc()..add(const TodoInitFetch()),
        // ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<DeleteTodoBloc, DeleteTodoState>(
            listener: (context, deleteState) {
              if (deleteState.status == DeleteTodoStatus.loading) {}

              if (deleteState.status == DeleteTodoStatus.failed) {}

              if (deleteState.status == DeleteTodoStatus.success) {
                context.read<TodoBloc>().add(const TodoInitFetch());
              }
            },
          ),
          BlocListener<LogoutCubit, LogoutState>(
            listener: (context, logoutState) {
              if (logoutState.status == LogoutStatus.loading) {}

              if (logoutState.status == LogoutStatus.failed) {}

              if (logoutState.status == LogoutStatus.success) {
                context.read<LoginBloc>().add(const LogoutTrigger());
                // Navigator.of(context).popUntil((route) => route.isFirst);
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => LoginScreen(),
                //   ),
                // );
              }
            },
          ),
        ],
        child: BlocBuilder<MultiSelectorCubit, MultiSelectorState>(
          builder: (multiSelectContext, multiSelectState) {
            return Scaffold(
              backgroundColor: Colors.purple[50],
              appBar: AppBar(
                backgroundColor: Colors.purple[50],
                leading: IconButton(
                  onPressed: () => multiSelectContext.read<LogoutCubit>().onLogout(),
                  icon: const Icon(Icons.logout_rounded),
                ),
                title: const Text(
                  'Todo Application',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                actions: [
                  if (!multiSelectState.selectEnabled)
                    BlocBuilder<TodoBloc, TodoState>(
                      builder: (todoContext, todoState) {
                        return TextButton(
                          onPressed: () async {
                            bool? isSaved = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditTodoScreen()));

                            if (isSaved!) {
                              if (context.mounted) {
                                todoContext.read<TodoBloc>().add(const TodoInitFetch());
                              }
                            }
                          },
                          child: const Text('Add Notes'),
                        );
                      },
                    ),
                  if (multiSelectState.selectEnabled)
                    TextButton(
                      onPressed: () => multiSelectContext.read<DeleteTodoBloc>().add(OnDeleteTodo(multiSelectState.selectedItems)),
                      child: const Text('Delete'),
                    ),
                  if (multiSelectState.selectEnabled)
                    TextButton(
                      onPressed: () => multiSelectContext.read<MultiSelectorCubit>().disableMultiSelect(),
                      child: const Text('Cancel'),
                    ),
                ],
              ),
              body: BlocBuilder<TodoBloc, TodoState>(
                builder: (todoContext, todoState) {
                  if (todoState.status == TodoStatus.loading) {
                    return SpinKitSpinningLines(
                      color: Colors.purple[300]!,
                    );
                  }
                  if (todoState.status == TodoStatus.failed) {
                    return errorMessage(context, todoState);
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      todoContext.read<TodoBloc>().add(const TodoInitFetch());
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'My saved todo list',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          if (todoState.data != null)
                          BlocBuilder<MultiSelectorCubit, MultiSelectorState>(
                            builder: (multiSelectContext, multiSelectState) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20.0,
                                    crossAxisSpacing: 20.0,
                                  ),
                                  shrinkWrap: true,
                                  children: [
                                    for (int i = 0; i < todoState.data!.todoItems .length; i++)
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          InkWell(
                                            borderRadius: BorderRadius.circular(8.0),
                                            splashColor: Colors.purple[100],
                                            highlightColor: Colors.purple[100],
                                            onTap: () async {
                                              if (multiSelectState.selectEnabled) {
                                                multiSelectContext.read<MultiSelectorCubit>().onSelect(todoState.data!.todoItems[i].id);
                                              } else {
                                                bool? isUpdated = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => AddEditTodoScreen(
                                                      formType: 'update',
                                                      todo: todoState.data!.todoItems[i],
                                                    ),
                                                  ),
                                                );

                                                if (isUpdated!) {
                                                  if (context.mounted) {
                                                    todoContext.read<TodoBloc>().add(const TodoInitFetch());
                                                  }
                                                }
                                              }
                                            },
                                            onLongPress: () async {
                                              if (!multiSelectState.selectEnabled) {
                                                multiSelectContext.read<MultiSelectorCubit>().enableMultiSelect();
                                                multiSelectContext.read<MultiSelectorCubit>().onSelect(todoState.data!.todoItems[i].id);
                                              } else {
                                                log('Cannot disable');
                                              }
                                            },
                                            child: Ink(
                                              height: 150,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.purple,
                                                  width: multiSelectState.selectEnabled
                                                      ? multiSelectState.selectedItems.contains(todoState.data!.todoItems[i].id)
                                                          ? 5.0
                                                          : 1.0
                                                      : 1.0,
                                                ),
                                                borderRadius: BorderRadius.circular(8.0),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    offset: Offset(5.0, 5.0),
                                                  )
                                                ],
                                              ),
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 10.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    todoState.data!.todoItems[i].title!,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                                                  ),
                                                  const SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Text(
                                                    todoState.data!.todoItems[i].content!,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 5,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (todoState.data!.todoItems[i].isFinished)
                                            Positioned(
                                              top: -10.0,
                                              right: -10.0,
                                              child: Icon(
                                                Icons.task_rounded,
                                                color: Colors.green[300],
                                              ),
                                            ),
                                        ],
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
