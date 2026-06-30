import '../../../../data/models/order_model.dart';

abstract class OrderState {}

class InitialOrderState extends OrderState {}

class LoadingOrderState extends OrderState {}

class LoadedOrderState extends OrderState {

  List<OrderModel> allOrders;

  LoadedOrderState({required this.allOrders});
}

class ErrorOrderState extends OrderState {

  String errorMsg;

  ErrorOrderState({required this.errorMsg});
}
