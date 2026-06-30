import 'package:ecommerce_app/app_utilities/app_constants/app_constants.dart';
import 'package:ecommerce_app/app_utilities/app_constants/app_url.dart';
import 'package:ecommerce_app/data/app_helper/api_helper.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_event.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiHelper apiHelper;

  UserBloc({required this.apiHelper}) : super(InitialUserState()) {
    on<SignupUserEvent>((event, emit) async {
      emit(LoadingUserState());

      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrl.signupUrl,
          myBodyParameters: {
            AppUserConstants.user_name: event.name,
            AppUserConstants.user_mob_no: event.mobile_number,
            AppUserConstants.user_email: event.email,
            AppUserConstants.user_password: event.password,
          }, isAuth: true
        );

        if (data["status"]) {
          emit(SuccessUserState());
        } else {
          emit(FailureUserState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(FailureUserState(errorMsg: e.toString()));
      }
    });

    on<LoginUserEvent>((event, emit) async {
      emit(LoadingUserState());

      try {
        dynamic data = await apiHelper.postAPI(
          url: AppUrl.loginUrl,
          myBodyParameters: {
            AppUserConstants.user_email: event.email,
            AppUserConstants.user_password: event.password,
          }, isAuth: true
        );

        if (data["status"]) {
          emit(SuccessUserState());

          SharedPreferences myPref = await SharedPreferences.getInstance();
          myPref.setString(
            AppUserConstants.user_token,
            data[AppUserConstants.user_token],
          );
        } else {
          emit(FailureUserState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(FailureUserState(errorMsg: e.toString()));
      }
    });
  }
}
