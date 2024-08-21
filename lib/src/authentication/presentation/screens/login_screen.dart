import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/global_core/global_cubits/widgtes_helper/widgets_helper_cubit.dart';
import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/presentation/blocs/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 170.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
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
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                              fontFamily: 'Poppins'
                            ),
                            children: [
                              TextSpan(
                                text: 'If you do now have an account yet you can click '
                              ),
                              TextSpan(
                                text: 'here',
                                style: TextStyle(
                                  color: Colors.purple,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: ' to create an account.'
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: _email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_rounded),
                            labelText: 'E-mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.purple),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[400]!),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[400]!),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == '') {
                              return 'E-mail textfield should not be empty';
                            }
                            if (!emailRegex.hasMatch(value)) {
                              return 'This is not a valid E-mail address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        BlocProvider<WidgetsHelperCubit<bool>>(
                          create: (context) => WidgetsHelperCubit<bool>(false), 
                          child: BlocBuilder<WidgetsHelperCubit<bool>, bool>(
                            builder: (context, showPassword) {
                              return TextFormField(
                                controller: _password,
                                obscureText: !showPassword,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () => context.read<WidgetsHelperCubit<bool>>().onUpdateState(!showPassword),
                                    icon: Icon(
                                      showPassword
                                        ? Icons.radio_button_on
                                        : Icons.radio_button_off,
                                    ),
                                  ),
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.purple),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red[400]!),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red[400]!),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value == '') {
                                    return 'Password textfield should not be empty';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                  OnLogin(
                                    LoginParameters(
                                      email: _email.text,
                                      password: _password.text
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)
                              ),
                            ),
                            icon: const Icon(
                              Icons.login_rounded,
                              color: Colors.white,
                            ),
                            label: const Text('Log in',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
