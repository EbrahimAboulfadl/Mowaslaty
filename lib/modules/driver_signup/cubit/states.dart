abstract class SignupStates {}

class SignupInitialState extends SignupStates {}

class PasswordVisibiltyState extends SignupStates {}

class SignupLoadingState extends SignupStates {}

class SignupSuccessState extends SignupStates {}

class SignupErrorState extends SignupStates {}

class CreateUserLoadingState extends SignupStates {}

class CreateUserSuccessState extends SignupStates {}

class CreateUserErrorState extends SignupStates {}
