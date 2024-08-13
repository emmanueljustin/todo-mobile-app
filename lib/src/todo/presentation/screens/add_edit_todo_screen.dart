import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/src/todo/core/parameters/parameters.dart';
import 'package:todoapp/src/todo/data/models/todo_item_model.dart';
import 'package:todoapp/src/todo/presentation/blocs/delete_todo/delete_todo_bloc.dart';
import 'package:todoapp/src/todo/presentation/blocs/update_todo/update_todo_bloc.dart';

import '../blocs/save_todo/save_todo_bloc.dart';
import '../cubits/toggle_finished/toggle_finished_cubit.dart';

enum SnackBarType { success, error }

class AddEditTodoScreen extends StatelessWidget {
  final String? formType;
  final TodoItemModel? todo;
  AddEditTodoScreen({this.formType, this.todo, super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

  final FocusNode _titleNode = FocusNode();
  final FocusNode _contentNode = FocusNode();

  void showSnackBar({required BuildContext context, required SnackBarType type, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type == SnackBarType.success ? Colors.green : Colors.red,    
        content: Row(
          children: [
            Icon(
              type == SnackBarType.success ? Icons.check : Icons.warning_amber_rounded,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(message,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ToggleFinishedCubit>(
          create: (context) => ToggleFinishedCubit()..onToggle(todo != null ? !todo!.isFinished : true),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<SaveTodoBloc, SaveTodoState>(
            listener: (context, saveState) {
              if (saveState.status == SaveTodoStatus.loading) {}

              if (saveState.status == SaveTodoStatus.failed) {
                showSnackBar(
                  context: context,
                  type: SnackBarType.error,
                  message: saveState.errorMessage,
                );
              }

              if (saveState.status == SaveTodoStatus.success) {
                showSnackBar(
                  context: context,
                  type: SnackBarType.success,
                  message: 'Succesfully saved the todo',
                );
                Navigator.of(context).pop(true);
              }
            },
          ),

          BlocListener<UpdateTodoBloc, UpdateTodoState>(
            listener: (context, updateState) {
              if (updateState.status == UpdateTodoStatus.loading) {}

              if (updateState.status == UpdateTodoStatus.failed) {
                showSnackBar(
                  context: context,
                  type: SnackBarType.error,
                  message: updateState.errorMessage,
                );
              }

              if (updateState.status == UpdateTodoStatus.success) {
                showSnackBar(
                  context: context,
                  type: SnackBarType.success,
                  message: 'Succesfully updated the todo',
                );
                Navigator.of(context).pop(true);
              }
            },
          ),

          BlocListener<DeleteTodoBloc, DeleteTodoState>(
            listener: (context, deleteState) {
              if (deleteState.status == DeleteTodoStatus.loading) {}

              if (deleteState.status == DeleteTodoStatus.failed) {
                showSnackBar(
                  context: context,
                  type: SnackBarType.error,
                  message: deleteState.errorMessage,
                );
              }

              if (deleteState.status == DeleteTodoStatus.success) {
                showSnackBar(
                  context: context,
                  type: SnackBarType.success,
                  message: 'Succesfully deleted the todo',
                );
                Navigator.of(context).pop(true);
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.purple[50],
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (formType != 'update')
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Add Your todo list here',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    BlocBuilder<ToggleFinishedCubit, bool>(
                      builder: (toggleContext, toggleState) {
                        if (formType == 'update') {
                          if (!_titleNode.hasFocus && !_contentNode.hasFocus) {
                            _title.text = todo!.title!;
                            _content.text = todo!.content!;
                          }
                        }
                        return Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _title,
                                focusNode: _titleNode,
                                textCapitalization: TextCapitalization.sentences,
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Title',
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: SizedBox(
                                  height: 250,
                                  child: TextFormField(
                                    controller: _content,
                                    focusNode: _contentNode,
                                    textCapitalization: TextCapitalization.sentences,
                                    expands: true,
                                    maxLines: null,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17.0,
                                    ),
                                    decoration: const InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: 'Content',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Switch(
                                          value: toggleState,
                                          onChanged: (value) {
                                            toggleContext.read<ToggleFinishedCubit>().onToggle(!value);
                                          },
                                        ),
                                      ),
                                      const Text(
                                        'Toggle if the todo task is finished.',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              if (formType != 'update')
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      toggleContext.read<SaveTodoBloc>().add(
                                            OnSaveTodo(
                                              TodoParams(
                                                title: _title.text,
                                                content: _content.text,
                                                priorityLevel: 5,
                                                isFinished: toggleState,
                                              ),
                                            ),
                                          );
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              if (formType == 'update')
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.purple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      toggleContext.read<UpdateTodoBloc>().add(
                                            OnUpdateTodo(
                                              TodoParams(
                                                id: todo!.id,
                                                title: _title.text,
                                                content: _content.text,
                                                priorityLevel: 5,
                                                isFinished: toggleState,
                                              ),
                                            ),
                                          );
                                    },
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              if (formType == 'update')
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      toggleContext.read<DeleteTodoBloc>().add(OnDeleteTodo([todo!.id!]));
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
