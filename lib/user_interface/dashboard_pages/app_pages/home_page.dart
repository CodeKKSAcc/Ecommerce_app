import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/data/models/wishlist_product_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_state.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> saleSlides = [
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

  int currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(FetchAllWishlistProductEvent());
    context.read<ProductBloc>().add(FetchAllProductEvent());  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 15, left: 15, top: 21),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 36),
                // Top Icon's
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF6F6F6),
                      ),
                      child: Icon(Icons.menu_outlined, size: 24),
                    ),
                    Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF6F6F6),
                      ),
                      child: Icon(Icons.notifications, size: 24),
                    ),
                  ],
                ),
                // Top search bar
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF6F6F6) /*Colors.blueGrey.shade50*/,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search...",
                    suffixIcon: Icon(Icons.tune_outlined),
                  ),
                ),
                SizedBox(height: 21),
                // Product banner
                StatefulBuilder(
                  builder: (context, S) {
                    return CarouselSlider.builder(
                      itemCount: saleSlides.length,
                      itemBuilder: (context, index, _) {
                        return Container(
                          height: 120,
                          width: double.infinity,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                              image: NetworkImage(saleSlides[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment(-0.75, 0.60),
                                child: Container(
                                  alignment: Alignment(0, 0),
                                  height: 36,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "Shop Now",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 1,
                                left: 1,
                                bottom: 9,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DotsIndicator(
                                    dotsCount: saleSlides.length,
                                    /*position: index.toDouble(),*/
                                    position: currentBannerIndex.toDouble(),
                                    animate: true,
                                    decorator: DotsDecorator(
                                      activeShape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadiusGeometry.circular(8),
                                      ),
                                      shape: CircleBorder(side: BorderSide()),
                                      activeColor: Colors.black87,
                                      color: Colors.transparent,
                                      activeSize: Size(27, 12),
                                      size: Size(12, 12),
                                      spacing: EdgeInsets.all(6),
                                    ),
                                    mainAxisSize: MainAxisSize.min,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (value, _) {
                          currentBannerIndex = value;
                          S(() {});
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 21),
                // Category Icon
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 12,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 78,
                            width: 78,
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color:
                              Colors.primaries[Random().nextInt(
                                Colors.primaries.length,
                              )],
                              borderRadius: BorderRadius.circular(39),
                            ),
                          ),
                          SizedBox(height: 9),
                          Text("Item $index"),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 18),
                // Special for you title
                Row(
                  children: [
                    Text(
                      "Special for you",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text("See all", style: TextStyle(fontSize: 15)),
                  ],
                ),
                // Item section
                BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {

                    if (state is LoadingWishlistState) {
                      return Center(child: CircularProgressIndicator(color: Colors.blue,));
                    }

                    if (state is ErrorWishlistState) {
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

                      List<WishlistProductModel> likedProducts = state.allLikedItems;

                      return BlocBuilder<ProductBloc, ProductState>(builder: (context, state){

                        if (state is LoadingProductState) {
                          return Center(child: CircularProgressIndicator(color: Colors.blue,));
                        }

                        if (state is ErrorProductState) {
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

                        if (state is LoadedProductState) {

                          return state.allProducts.isNotEmpty
                              ? GridView.builder(
                            itemCount: state.allProducts.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {

                              ProductModel myProduct =
                              state.allProducts[index];

                              bool isLiked = false;

                              for(WishlistProductModel prod in likedProducts){

                                if(prod.productId == int.parse(myProduct.id)){
                                  isLiked = true;
                                  break;
                                }
                              }

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductPage(
                                        imageLink:
                                        myProduct.image ??
                                            "https://shop.timexindia.com/cdn/shop/files/TWEG26704_1.jpg?v=1748513330",
                                        price: myProduct.price ?? "0",
                                        name: myProduct.name ?? "Error",
                                        product_id: int.parse(myProduct.id),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 180,
                                  width: 45,
                                  //alignment: Alignment(0, 0),
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        myProduct.image ??
                                            "https://edit.org/img/blog/z3i-sale-poster-template-free-edit-online.webp",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment(1, -1),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {

                                              if(isLiked){

                                                context.read<WishlistBloc>().add(DeleteAllWishlistProductEvent(productId: int.parse(myProduct.id)));
                                              } else {
                                                context.read<WishlistBloc>().add(
                                                    AddAllWishlistProductEvent(
                                                        likedItem: WishlistProductModel(image: myProduct.image ?? "",
                                                            name: myProduct.name ?? "",
                                                            price: myProduct.price != null ? double.parse(myProduct.price!) : 0,
                                                            productId: int.parse(myProduct.id))));
                                              }

                                            },
                                            icon: Container(
                                              alignment: Alignment(0, 0),
                                              height: 42,
                                              width: 42,
                                              // padding: EdgeInsets.all(9),
                                              decoration: BoxDecoration(
                                                color: Colors.white ,
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              child: Icon(
                                                Icons.favorite,
                                                color: isLiked
                                                    ? Colors.red
                                                    : Colors.white,
                                              ),
                                            ),
                                          )

                                      ),
                                      Align(
                                        alignment: Alignment(0.9, 0.9),
                                        child: SizedBox(
                                          height: 20,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListView.builder(
                                                itemCount: 4,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                Axis.horizontal,
                                                itemBuilder: (context, indx) {
                                                  return Container(
                                                    height: 20,
                                                    width: 20,
                                                    margin: EdgeInsets.only(
                                                      right: 6,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                      Colors
                                                          .primaries[Random()
                                                          .nextInt(
                                                        Colors
                                                            .primaries
                                                            .length,
                                                      )],
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(-0.9, 0.6),
                                        child: Text(
                                          myProduct.name ?? "",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 171,
                                        right: 144,
                                        child: Text(
                                          "\$${myProduct.price.toString()}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                              : Center(
                            child: Text(
                              "No Products Yet !!!",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                          ;
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

                      });
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
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*Image.network("https://www.magnific.com/free-photos-vectors/shoes-poster")*/
