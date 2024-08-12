import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/src/todo/core/parameters/parameters.dart';

import '../blocs/save_todo/save_todo_bloc.dart';
import '../cubits/toggle_finished/toggle_finished_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<ToggleFinishedCubit>(
          create: (context) => ToggleFinishedCubit(),
        ),
        BlocProvider<SaveTodoBloc>(
          create: (context) => SaveTodoBloc(),
        ),
      ],
      child: BlocListener<SaveTodoBloc, SaveTodoState>(
        listener: (context, saveState) {
          if (saveState.status == SaveTodoStatus.success) {
            Navigator.of(context).pop(true);
          }
        },
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
                    const SizedBox(
                      height: 20.0,
                    ),
                    BlocBuilder<ToggleFinishedCubit, bool>(
                      builder: (toggleContext, toggleState) {
                        return Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _title,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25.0),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Title',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
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
                                    textCapitalization:
                                        TextCapitalization.sentences,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Switch(
                                          value: toggleState,
                                          onChanged: (value) => toggleContext
                                              .read<ToggleFinishedCubit>()
                                              .onToggle(!value),
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
