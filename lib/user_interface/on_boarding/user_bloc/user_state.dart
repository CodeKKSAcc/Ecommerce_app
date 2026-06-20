abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class SuccessUserState extends UserState {}

class FailureUserState extends UserState {

  String errorMsg;
  FailureUserState({required this.errorMsg});
}