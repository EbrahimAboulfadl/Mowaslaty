import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/modules/driver_homescreen/driver_homescreen.dart';
import 'package:wasalny/modules/driver_signin/cubit/states.dart';

class SigninCubit extends Cubit<SigninStates> {
  SigninCubit() : super(SigninInitialState());
  static SigninCubit get(context) => BlocProvider.of(context);
  bool hidePassword = true;
  void reset() {
    emit(SigninInitialState());
  }

  void driverLogin(
      {required String email, required String password, required var context}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DriverHomeScreen()));
      emit(LoginSuccessState());
    }).catchError((e) {
      emit(LoginErrorState(e.toString()));
    });
  }

  void passwordHide() {
    hidePassword = !hidePassword;
    emit(PasswordVisibiltyState());
  }
}
