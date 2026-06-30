import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/data/models/wishlist_product_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  /*List<String> saleSlides = [
    "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_retail-sale-posters-362a517f195f1af49f562d3f925c2c12.jpg?ts%20=%201706181157",
    "https://edit.org/img/blog/z3i-sale-poster-template-free-edit-online.webp",
    "https://i.pinimg.com/736x/80/0e/7c/800e7ce624197ee30048c32d2b57254f.jpg",
    "https://t4.ftcdn.net/jpg/04/86/53/23/360_F_486532393_IZOMHnhTFf7d88iDT8YCNAhSq6FRjd5u.jpg",
    "https://edit.org/img/blog/3q9-free-sale-sign-templates-online.webp",
    "https://image.shutterstock.com/image-vector/winter-big-sale-banner-snow-260nw-2698748061.jpg",
    "https://dynamic.design.com/template/preview/design/30bad16b-9d9a-4abf-a6c9-ca66cadd9b62?v=4&designTemplateVersion=1&size=design-preview-tall-2x&layout=auto-1-1"
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSo87yQLScGu6Qk1DnlHUDDtTHe6T9citZiwg&s",
    "https://i.pinimg.com/736x/5b/c4/de/5bc4de18edff4b8436ac37a57ff168a1.jpg",
  ];

  List<String> productImages = [
    "https://shop.timexindia.com/cdn/shop/files/TWEG26704_1.jpg?v=1748513330",
    "https://m.media-amazon.com/images/I/81ZQ1YJ1xQL._AC_UY1000_.jpg",
    "https://shop.timexindia.com/cdn/shop/files/02680_WB23_September_flatlay_background_imagery_TW2W10400_mobile_3e2ec263-8e8f-4f42-a653-a9f268ac4e17.jpg?v=1759837905",
    "https://www.watches.com/cdn/shop/files/timex-marlin-chronograph-tachymeter-40mm-blue-tw2w99000vq-188772_1080x.jpg?v=1749278049",
  ];*/

  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(FetchAllWishlistProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15),
        child: BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state){

          if(state is LoadingWishlistState){
            return Center(child: CircularProgressIndicator(color: Colors.blue,));
          }

          if(state is ErrorWishlistState){
            return Center(
              child: Text(
                state.errorMsg,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          if(state is LoadedWishlistState){

            List<WishlistProductModel> allLikedProducts = state.allLikedItems;

            return allLikedProducts.isNotEmpty ? ListView.builder(
              itemCount: allLikedProducts.length,
                itemBuilder: (context, index){
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 15,
                ),
                margin: EdgeInsets.only(
                  top: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(21),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      allLikedProducts[index].image,
                      height: 90,
                      width: 90,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 36),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allLikedProducts[index].name,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Product Id: ${allLikedProducts[index].productId}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Price: \$${allLikedProducts[index].price}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ) ;
            }) : Center(
              child: Text(
                "No Liked Product Yet !!!",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return Center(
            child: Text(
              "Unknown Error !!!",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
      ),
    );
  }
}
