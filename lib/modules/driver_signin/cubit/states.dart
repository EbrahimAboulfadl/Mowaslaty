abstract class SigninStates {}

class SigninInitialState extends SigninStates {}

class PasswordVisibiltyState extends SigninStates {}

class LoginSuccessState extends SigninStates {}

class LoginErrorState extends SigninStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginLoadingState extends SigninStates {}
