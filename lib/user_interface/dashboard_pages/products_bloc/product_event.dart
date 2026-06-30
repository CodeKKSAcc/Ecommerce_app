abstract class ProductEvent {}

class FetchAllProductEvent extends ProductEvent {}

class FilterProductEvent extends ProductEvent {

  String category_id;
  FilterProductEvent({required this.category_id});
}

