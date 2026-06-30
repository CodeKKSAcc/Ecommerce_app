import 'package:ecommerce_app/app_utilities/app_constants/app_url.dart';
import 'package:ecommerce_app/data/app_helper/api_helper.dart';
import 'package:ecommerce_app/data/models/category_product_model.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{

  ApiHelper apiHelper;

  ProductBloc({required this.apiHelper}) : super(InitialProductState()) {

    on<FetchAllProductEvent>((event, emit) async{

      emit(LoadingProductState());

      try {

        dynamic myData = await apiHelper.postAPI(url: AppUrl.getProductsUrl);
        if(myData["status"]){

          List<ProductModel> allProducts = [];

          List<dynamic> products = myData["data"];

          for(Map<String, dynamic> prod in products) {
            allProducts.add(ProductModel.fromJson(prod));
          }

          emit(LoadedProductState(allProducts: allProducts));

        } else {
          emit(ErrorProductState(errorMsg: myData["message"]));
        }
      } catch (e) {
        emit(ErrorProductState(errorMsg: e.toString()));
      }
    });

    on<FilterProductEvent>((event, emit) async{

      emit(LoadingProductState());

      try {

        dynamic myData = await apiHelper.postAPI(url: AppUrl.getProductsUrl, myBodyParameters: {
          "category_id": int.parse(event.category_id)
        });
        if(myData["status"]){

          List<ProductModel> allProducts = [];

          List<dynamic> products = myData["data"];

          for(Map<String, dynamic> prod in products) {
            allProducts.add(ProductModel.fromJson(prod));
          }

          emit(LoadedProductState(allProducts: allProducts));

        } else {
          emit(ErrorProductState(errorMsg: myData["message"]));
        }
      } catch (e) {
        emit(ErrorProductState(errorMsg: e.toString()));
      }
    });
  }
}