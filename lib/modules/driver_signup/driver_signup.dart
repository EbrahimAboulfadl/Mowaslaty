import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/modules/driver_signup/cubit/cubit.dart';
import 'package:wasalny/modules/driver_signup/cubit/states.dart';
import 'package:wasalny/shared/components/components.dart';
import 'package:wasalny/shared/constatnts/constants.dart';

class DriverSignup extends StatelessWidget {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SignupCubit cubit = SignupCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 1,
                          child: Center(
                            child: Image(
                                height: 220,
                                width: 220,
                                image: AssetImage(
                                  'lib/images/logo.png',
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            onTap: () {
                              cubit.reset();
                            },
                            color: kSecColor,
                            controller: nameController,
                            label: 'Name',
                            keyboardtype: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('Name must be not empty');
                              } else if (value.isNotEmpty) {
                                return null;
                              }
                            },
                            icon: Icons.person),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            onTap: () {
                              cubit.reset();
                            },
                            color: kSecColor,
                            controller: emailController,
                            label: 'E-mail',
                            keyboardtype: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('E-mail must be not empty');
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
                            isPassword: cubit.hidePassword,
                            suffixIcon: cubit.hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixOnTap: () {
                              cubit.passwordHide();
                            },
                            color: kSecColor,
                            controller: passwordController,
                            label: 'Password',
                            keyboardtype: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('Password must be not empty');
                              } else if (value.isNotEmpty) {
                                return null;
                              }
                            },
                            icon: Icons.lock_outline),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextForm(
                            onTap: () {
                              cubit.reset();
                            },
                            color: kSecColor,
                            controller: phoneController,
                            label: 'phone',
                            keyboardtype: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ('Phone must be not empty');
                              } else if (value.isNotEmpty) {
                                return null;
                              }
                            },
                            icon: Icons.phone),
                        SizedBox(
                          height: 20,
                        ),
                        state is! SignupLoadingState
                            ? defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userSignup(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        username: nameController.text,
                                        phone: phoneController.text,
                                        context: context);
                                  }
                                },
                                text: state is SignupErrorState
                                    ? 'something went wrong!'
                                    : 'Sign Up',
                                color: state is SignupErrorState
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
                                )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
