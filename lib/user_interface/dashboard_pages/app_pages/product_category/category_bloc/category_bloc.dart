

import 'package:ecommerce_app/data/app_helper/api_helper.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_category/category_bloc/category_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_category/category_bloc/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app_utilities/app_constants/app_url.dart';
import '../../../../../data/models/category_product_model.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>{

  ApiHelper apiHelper;

  CategoryBloc({required this.apiHelper}) : super(InitialCategoryState()){

    on<FetchAllProductByCategoryEvent>((event, emit) async{

      emit(LoadingCategoryState());

      try {

        dynamic data = await apiHelper.getAPI(url: AppUrl.categoryProductsUrl);

        if(data["status"]){

          List<CategoryProductModel> allCatProd = [];

          for(Map<String, dynamic> prod in data["data"]){
            allCatProd.add(CategoryProductModel.fromJson(prod));
          }

          emit(LoadedProductCategoryState(allCatProducts: allCatProd));
        } else {
          emit(ErrorCategoryState(errorMsg: data["message"]));
        }

      } catch (e) {
        emit(ErrorCategoryState(errorMsg: e.toString()));
      }
    });

  }
}