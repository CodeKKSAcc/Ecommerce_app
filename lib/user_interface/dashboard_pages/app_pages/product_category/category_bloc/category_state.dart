

import '../../../../../data/models/category_product_model.dart';

abstract class CategoryState {}

class InitialCategoryState extends CategoryState{}

class LoadingCategoryState extends CategoryState{}

class LoadedProductCategoryState extends CategoryState {
  List<CategoryProductModel> allCatProducts;

  LoadedProductCategoryState({required this.allCatProducts});
}

class ErrorCategoryState extends CategoryState{

  String errorMsg;
  ErrorCategoryState({required this.errorMsg});
}
