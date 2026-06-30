

import 'package:ecommerce_app/app_utilities/app_constants/app_constants.dart';
import 'package:ecommerce_app/app_utilities/app_constants/app_url.dart';
import 'package:ecommerce_app/data/app_helper/api_helper.dart';
import 'package:ecommerce_app/data/models/cart_product_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page/cart_bloc/cart_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page/cart_bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends Bloc<CartEvent, CartState>{

  ApiHelper apiHelper;

  CartBloc({required this.apiHelper}) : super(CartInitialState()) {

    on<AddToCartEvent>((event, emit) async{

      emit(CartLoadingState());

      SharedPreferences myPref = await SharedPreferences.getInstance();
      int userId = myPref.getInt(AppUserConstants.user_id) ?? 584;

      try {

        dynamic data = await apiHelper.postAPI(url: AppUrl.addToCartUrl, myBodyParameters: {
          "user_id": userId,
          "product_id": event.product_id,
          "quantity": event.quantity
        });

        if(data["status"]){
          emit(CartSuccessState(successMsg: data["message"]));
        } else {
          emit(CartFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });

    on<FetchAllCartItemEvent>((event, emit) async{

      emit(CartLoadingState());

      try {

      dynamic data = await apiHelper.getAPI(url: AppUrl.viewCartUrl);

      List<CartProductModel> allProducts = [];

      if(data["status"] == true && data["data"] != null){

        for(Map<String, dynamic> product in data["data"]){
          allProducts.add(CartProductModel.fromJson(product));
        }

      }

      if(data["status"]){
        emit(CartLoadedState(allProductsInCart: allProducts));
      }
      else if(data["data"] == null){
        emit(CartLoadedState(allProductsInCart: []));
      } else {
        emit(CartFailureState(errorMsg: data["message"]));
      }
    } catch (e) {
      emit(CartFailureState(errorMsg: e.toString()));
    }
    });

    on<CartItemNumberEvent>((event, emit) async{

      emit(CartLoadingState());

      try {

        SharedPreferences myPref = await SharedPreferences.getInstance();
        int userId = myPref.getInt(AppUserConstants.user_id) ?? 0;

        dynamic data = await apiHelper.postAPI(url: AppUrl.decrementCartItemQuantity, myBodyParameters: {
          "user_id" : userId,
          "product_id" : event.product_id,
          "quantity" : event.quantity
        });

        if(data["status"]){
          emit(CartSuccessState(successMsg: "Item Updated Successfully"));
        }
        else if(data["data"] == null){
          emit(CartLoadedState(allProductsInCart: []));
        }
        else {
          emit(CartFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }

      emit(CartLoadingState());

      try {

        dynamic data = await apiHelper.getAPI(url: AppUrl.viewCartUrl);

        List<CartProductModel> allProducts = [];

        if(data["status"]){

        for(Map<String, dynamic> product in data["data"]){
          allProducts.add(CartProductModel.fromJson(product));
        }

          emit(CartLoadedState(allProductsInCart: allProducts));
        }
        /*else if(data["data"] == null){
          emit(CartLoadedState(allProductsInCart: []));
        }*/
        else {
          emit(CartLoadedState(allProductsInCart: []));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });

    on<DeleteCartEvent>((event, emit) async{

      emit(CartLoadingState());

      try {

        dynamic data = await apiHelper.postAPI(url: AppUrl.deleteCart, myBodyParameters: {
          "cart_id" : event.cart_id
        });

        if(data["status"]){
          /*emit(CartSuccessState(successMsg: data["Item deleted successfully"]));*/
          emit(CartLoadedState(allProductsInCart: []));
        }
        else {
          emit(CartFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }

      emit(CartLoadingState());

      try {

        dynamic data = await apiHelper.getAPI(url: AppUrl.viewCartUrl);

        List<CartProductModel> allProducts = [];

        if(data["status"]){

        for(Map<String, dynamic> product in data["data"]){
          allProducts.add(CartProductModel.fromJson(product));
        }

          emit(CartLoadedState(allProductsInCart: allProducts));
        }
        else if(data["data"] == null){

          emit(CartLoadedState(allProductsInCart: []));
        }
        else {
          emit(CartLoadedState(allProductsInCart: []));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }

    });

    on<OrderCartEvent>((event, emit) async{

      emit(CartLoadingState());

      try {

        SharedPreferences myPref = await SharedPreferences.getInstance();
        int userId = myPref.getInt(AppUserConstants.user_id) ?? 0;

        dynamic data = await apiHelper.postAPI(url: AppUrl.createOrderUrl, myBodyParameters: {
          "user_id" : userId,
          "product_id" : event.product_id,
          "status" : event.status
        });

        if(data["status"]){

          emit(CartSuccessState(successMsg: "Order Created Successfully"));

          emit(CartLoadingState());

          emit(CartLoadedState(allProductsInCart: []));
        } else {
          emit(CartFailureState(errorMsg: data["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });
  }
}