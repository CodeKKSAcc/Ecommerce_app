abstract class UserEvent {}

class LoginUserEvent extends UserEvent {
  String email, password;

  LoginUserEvent({required this.email, required this.password});
}

class SignupUserEvent extends UserEvent {
  String name, mobile_number, email, password;

  SignupUserEvent({
    required this.name,
    required this.mobile_number,
    required this.email,
    required this.password,
  });
}
