

import 'package:ecommerce_app/app_utilities/app_constants/app_url.dart';
import 'package:ecommerce_app/data/app_helper/api_helper.dart';
import 'package:ecommerce_app/data/models/user_profile_data_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/user_profile/profile_bloc/profile_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/user_profile/profile_bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  ApiHelper apiHelper;

  ProfileBloc({required this.apiHelper}) : super(InitialProfileState()){

    on<FetchAllProfileDataEvent>((event, emit) async{

      emit(LoadingProfileState());

      try{

        dynamic data = await apiHelper.postAPI(url: AppUrl.userProfileUrl);

        if(data["status"]){
          emit(LoadedProfileState(profileData: UserProfileDataModel.fromJson(data["data"])));
        } else {
          emit(FailureProfileState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(FailureProfileState(errorMsg: e.toString()));
      }

    });

  }
}