import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/models/users_model.dart';
import 'package:wasalny/modules/driver_homescreen/driver_homescreen.dart';
import 'package:wasalny/modules/driver_signup/cubit/states.dart';
import 'package:flutter/material.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());
  static SignupCubit get(context) => BlocProvider.of(context);
  bool hidePassword = true;
  void reset() {
    emit(SignupInitialState());
  }

  void userSignup(
      {required String email,
      required String password,
      required String username,
      required String phone,
      required var context}) {
    emit(SignupLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DriverHomeScreen()));
      createUser(
          email: email, name: username, phone: phone, uId: value.user!.uid);
      emit(SignupSuccessState());
    }).catchError((e) {
      emit(SignupErrorState());
    });
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel model =
        UserModel(name: name, email: email, phone: phone, uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((e) {
      emit(CreateUserErrorState());
    });
  }

  void passwordHide() {
    hidePassword = !hidePassword;
    emit(PasswordVisibiltyState());
  }
}
