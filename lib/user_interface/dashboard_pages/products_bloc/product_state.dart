import 'package:ecommerce_app/data/models/category_product_model.dart';
import 'package:ecommerce_app/data/models/product_model.dart';

abstract class ProductState {}

class InitialProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class LoadedProductState extends ProductState {
  List<ProductModel> allProducts;

  LoadedProductState({required this.allProducts});
}

class ErrorProductState extends ProductState {
  String errorMsg;

  ErrorProductState({required this.errorMsg});
}
