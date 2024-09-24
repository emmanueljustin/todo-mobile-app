import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todoapp/src/authentication/core/parameters/auth_parameters.dart';
import 'package:todoapp/src/authentication/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:todoapp/src/authentication/presentation/blocs/register_bloc/register_bloc.dart';

import '../../../../global_core/global_cubits/widgtes_helper/widgets_helper_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, registerState) {
          if (registerState.status == RegistrationStatus.loading) {}

          if (registerState.status == RegistrationStatus.failed) {}

          if (registerState.status == RegistrationStatus.success) {
            context.read<LoginBloc>().add(const OnLoginStarted());
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
            if (registerState.status == RegistrationStatus.loading) {
              return Center(
                child: SpinKitSpinningLines(
                  color: Colors.purple[300]!,
                ),
              );
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 70.0,
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
                            ),
                          ],
                        ),
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                'Create your own account to access this amazing application.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                controller: _name,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp("[ a-zA-Z]")),
                                ],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person_rounded),
                                  labelText: 'Username',
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
                                  if (value != null) {
                                    if (value.isEmpty || value == '') {
                                      return 'Name must not be empty.';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                controller: _email,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
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
                                          icon: Icon(showPassword ? Icons.radio_button_on : Icons.radio_button_off),
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
                                        if (value != null) {
                                          if (value.isEmpty || value == '') {
                                            return 'Password must not be empty.';
                                          }
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
                              BlocProvider<WidgetsHelperCubit<bool>>(
                                create: (context) => WidgetsHelperCubit<bool>(false),
                                child: BlocBuilder<WidgetsHelperCubit<bool>, bool>(
                                  builder: (context, showPassword) {
                                    return TextFormField(
                                      controller: _confirmPassword,
                                      obscureText: !showPassword,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                          onPressed: () => context.read<WidgetsHelperCubit<bool>>().onUpdateState(!showPassword),
                                          icon: Icon(showPassword ? Icons.radio_button_on : Icons.radio_button_off),
                                        ),
                                        labelText: 'Confirm Password',
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
                                        if (value != null) {
                                          if (value.isEmpty || value == '') {
                                            return 'Confirm password must not be empty.';
                                          }
                                          if (value != _password.text) {
                                            return 'Your input does not match to your input in password field';
                                          }
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
                                      context.read<RegisterBloc>().add(
                                            OnRegisterUser(
                                              RegistrationParameters(
                                                username: _name.text,
                                                email: _email.text,
                                                password: _password.text,
                                              ),
                                            ),
                                          );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                                  icon: const Icon(
                                    Icons.create_rounded,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Create Account',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton.icon(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: const BorderSide(
                                        color: Colors.purple,
                                        width: 2.0,
                                      ),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.purple,
                                  ),
                                  label: const Text(
                                    'Back',
                                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
