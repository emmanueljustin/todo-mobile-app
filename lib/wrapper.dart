import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todoapp/src/authentication/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:todoapp/src/authentication/presentation/screens/login_screen.dart';
import 'package:todoapp/src/todo/presentation/screens/todo_home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<LoginBloc>().state.status;
    // if (authCheck == LoginStatus.success) {
    //   return const TodoHome();
    // } else {
    //   return LoginScreen();
    // }

    switch (authStatus) {
      case LoginStatus.loading:
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: SpinKitSpinningLines(
                color: Colors.purple[300]!,
              ),
            ),
          ),
        );
      case LoginStatus.success:
        return const TodoHome();
      default:
        return LoginScreen();
    }
  }
}