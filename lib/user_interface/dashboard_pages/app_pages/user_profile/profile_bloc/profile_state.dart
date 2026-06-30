

import '../../../../../data/models/user_profile_data_model.dart';

abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadedProfileState extends ProfileState {

  UserProfileDataModel profileData;
  LoadedProfileState({required this.profileData});
}

class FailureProfileState extends ProfileState {

  String errorMsg;
  FailureProfileState({required this.errorMsg});
}