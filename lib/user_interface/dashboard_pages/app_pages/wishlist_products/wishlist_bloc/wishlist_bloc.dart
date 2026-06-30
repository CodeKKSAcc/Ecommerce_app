import 'package:ecommerce_app/data/app_helper/database_helper.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  DatabaseHelper databaseHelper;

  WishlistBloc({required this.databaseHelper}) : super(InitialWishlistState()) {
    on<AddAllWishlistProductEvent>((event, emit) async {
      emit(LoadingWishlistState());

      try {
        bool isAdded = await databaseHelper.addWishlistProduct(event.likedItem);

        if (isAdded) {
          emit(
            LoadedWishlistState(
              allLikedItems: await databaseHelper.fetchWishlistProduct(),
            ),
          );
        } else {
          emit(ErrorWishlistState(errorMsg: "Database Error !!!"));
        }
      } catch (e) {
        emit(ErrorWishlistState(errorMsg: e.toString()));
      }
    });

    on<FetchAllWishlistProductEvent>((event, emit) async {
      emit(LoadingWishlistState());

      try {
        emit(
          LoadedWishlistState(
            allLikedItems: await databaseHelper.fetchWishlistProduct(),
          ),
        );
      } catch (e) {
        emit(ErrorWishlistState(errorMsg: e.toString()));
      }
    });

    on<DeleteAllWishlistProductEvent>((event, emit) async{

      emit(LoadingWishlistState());

      try {
        bool isDeleted = await databaseHelper.deleteWishlistProduct(productId: event.productId);
        if(isDeleted){
          emit(LoadedWishlistState(allLikedItems: await databaseHelper.fetchWishlistProduct()));
        } else {
          emit(ErrorWishlistState(errorMsg: "Database Error !!!"));
        }
      } catch (e){
        emit(ErrorWishlistState(errorMsg: e.toString()));
      }
    });
  }
}
