import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todoapp/src/todo/presentation/blocs/todo/todo_bloc.dart';
import 'package:todoapp/src/todo/presentation/screens/add_todo_screen.dart';

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
            onPressed: () => context.read<TodoBloc>().add(const TodoFetchAll()),
            child: const Text('Reload'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => TodoBloc()..add(const TodoFetchAll()),
      child: Scaffold(
        backgroundColor: Colors.purple[50],
        appBar: AppBar(
          backgroundColor: Colors.purple[50],
          title: const Text(
            'Todo Application',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            BlocBuilder<TodoBloc, TodoState>(
              builder: (todoContext, todoState) {
                return TextButton(
                  onPressed: () async {
                    bool? isSaved = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoScreen()));

                    if (isSaved!) {
                      if (context.mounted) {
                        todoContext.read<TodoBloc>().add(const TodoFetchAll());
                      }
                    }
                  },
                  child: const Text('Add Notes'),
                );
              },
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
                todoContext.read<TodoBloc>().add(const TodoFetchAll());
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
                    Container(
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
                          for (int i = 0; i < todoState.data.length; i++)
                            InkWell(
                              borderRadius: BorderRadius.circular(8.0),
                              splashColor: Colors.purple[100],
                              highlightColor: Colors.purple[100],
                              onTap: () => log('${todoState.data[i]}'),
                              child: Ink(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                      todoState.data[i].title!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Text(
                                      todoState.data[i].content!,
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
                        ],
                      ),
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
      ),
    );
  }
}
