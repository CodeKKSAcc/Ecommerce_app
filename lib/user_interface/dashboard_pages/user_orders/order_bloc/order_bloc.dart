

import 'package:ecommerce_app/data/app_helper/api_helper.dart';
import 'package:ecommerce_app/data/models/order_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/user_orders/order_bloc/order_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/user_orders/order_bloc/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app_utilities/app_constants/app_constants.dart';
import '../../../../app_utilities/app_constants/app_url.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{

  ApiHelper apiHelper;

  OrderBloc({required this.apiHelper}) : super(InitialOrderState()){

    on<FetchAllOrderEvent>((event, emit) async{

      emit(LoadingOrderState());

      try {

        SharedPreferences myPref = await SharedPreferences.getInstance();
        int userId = myPref.getInt(AppUserConstants.user_id) ?? 0;

        dynamic data = await apiHelper.postAPI(url: AppUrl.getOrderUrl, myBodyParameters: {
          "user_id" : userId
        });

        if(data["status"]){

          List<OrderModel> allOrders = [];

          for(Map<String, dynamic> orders in data["orders"]){
            allOrders.add(OrderModel.fromJson(orders));
          }

          emit(LoadedOrderState(allOrders: allOrders));
        } else {
          emit(ErrorOrderState(errorMsg: data["message"]));
        }

      } catch (e) {
        emit(ErrorOrderState(errorMsg: e.toString()));
      }
    });
  }
}

/*
class OrderBloc extends Bloc<OrderEvent, OrderState>{

  ApiHelper apiHelper;

  OrderBloc({required this.apiHelper}) : super(InitialOrderState()){

    on<FetchAllOrderEvent>((event, emit) async{

      emit(LoadingOrderState());

      try {

        SharedPreferences myPref = await SharedPreferences.getInstance();
        int userId = myPref.getInt(AppUserConstants.user_id) ?? 0;

        dynamic data = await apiHelper.postAPI(url: AppUrl.getOrderUrl, myBodyParameters: {
          "user_id" : userId
        });

        if(data["status"] || data["status"] == "status"){

          List<OrderModel> allOrders = [];

          for(Map<String, dynamic> orders in data["orders"]){
            allOrders.add(OrderModel.fromJson(orders));
          }

          emit(LoadedOrderState(allOrders: allOrders));
        } else {
          emit(ErrorOrderState(errorMsg: data["message"]));
        }

      } catch (e) {
        emit(ErrorOrderState(errorMsg: e.toString()));
      }
    });
  }
}*/
