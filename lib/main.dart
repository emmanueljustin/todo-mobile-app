import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/global_core/hive_service/hive_boxes.dart';
import 'package:todoapp/global_core/providers/bloc_providers.dart';
import 'package:todoapp/src/authentication/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:todoapp/src/authentication/presentation/screens/login_screen.dart';

import 'global_core/locator.dart';
import 'src/todo/presentation/screens/todo_home.dart';
// import 'src/todo/presentation/screens/todo_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveBoxes().registerAdapters();
  await setupLocator();
  runApp(
    MultiBlocProvider(
      providers: BlocProviders.get(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc()..add(const OnLoginStarted()),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, loginState) {
            if (loginState.status == LoginStatus.loading) {
              return const Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            return loginState.status == LoginStatus.success ? const TodoHome() : LoginScreen();
          },
        ),
      ),
    );
  }
}
