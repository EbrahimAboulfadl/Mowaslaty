import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/modules/driver_signin/cubit/cubit.dart';
import 'package:wasalny/modules/driver_signin/cubit/states.dart';
import 'package:wasalny/modules/driver_signup/driver_signup.dart';
import 'package:wasalny/shared/components/components.dart';
import 'package:wasalny/shared/constatnts/constants.dart';

class DriverSignIn extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SigninCubit(),
      child: BlocConsumer<SigninCubit, SigninStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SigninCubit cubit = SigninCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Hero(
                        tag: 1,
                        child: Image(
                            height: 220,
                            width: 220,
                            image: AssetImage(
                              'lib/images/logo.png',
                            )),
                      ),
                    ),
                    defaultTextForm(
                        onTap: () {
                          cubit.reset();
                        },
                        color: kSecColor,
                        controller: emailController,
                        label: 'Enter your E-mail',
                        keyboardtype: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Email must be not empty');
                          } else if (value.isNotEmpty) {
                            return null;
                          }
                        },
                        icon: Icons.email_outlined),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextForm(
                        onTap: () {
                          cubit.reset();
                        },
                        suffixIcon: cubit.hidePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        isPassword: cubit.hidePassword,
                        color: kSecColor,
                        controller: passwordController,
                        label: 'Enter your password',
                        keyboardtype: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Password must be not empty');
                          } else if (value.isNotEmpty) {
                            return null;
                          }
                        },
                        icon: Icons.lock_outline,
                        suffixOnTap: () {
                          cubit.passwordHide();
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    state is! LoginLoadingState
                        ? defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.driverLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context);
                              }
                            },
                            text: state is LoginErrorState
                                ? 'Wrong E-mail or password!'
                                : 'Sign In',
                            color: state is LoginErrorState
                                ? Colors.red
                                : kMainColor)
                        : Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                color: kMainColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'don\'t have an account?',
                            style: TextStyle(color: kSecColor),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DriverSignup()));
                              },
                              child: Text(
                                'Sign up!',
                                style: TextStyle(color: kMainColor),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
