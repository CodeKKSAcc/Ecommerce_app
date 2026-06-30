

import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_category/category_bloc/category_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/category_product_model.dart';
import '../../../../data/models/product_model.dart';
import 'category_bloc/category_event.dart';
import 'category_bloc/category_state.dart';

class CategoryDisplayPage extends StatefulWidget {
  const CategoryDisplayPage({super.key});

  @override
  State<CategoryDisplayPage> createState() => _CategoryDisplayPageState();
}

class _CategoryDisplayPageState extends State<CategoryDisplayPage> {

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchAllProductByCategoryEvent());
    context.read<ProductBloc>().add(FetchAllProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state){

        if(state is LoadingCategoryState){
          return Center(child: CircularProgressIndicator(color: Colors.blue,));
        }

        if(state is ErrorCategoryState){
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

        if(state is LoadedProductCategoryState){

          List<CategoryProductModel> allCatProducts = state.allCatProducts;

          return BlocBuilder<ProductBloc, ProductState>(builder: (context, state){

            if(state is LoadingProductState){
              return Center(child: CircularProgressIndicator(color: Colors.blue,));
            }

            if(state is ErrorProductState){
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

            if(state is LoadedProductState){

              List<ProductModel> allProducts = state.allProducts;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Filter By Category", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                    SizedBox(height: 15,),
                    allCatProducts.isNotEmpty ? SizedBox(
                      height: 60,
                      child: ListView.builder(
                          itemCount: allCatProducts.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                context.read<ProductBloc>().add(FilterProductEvent(category_id: allCatProducts[index].id.toString()));
                              },
                              child: Container(
                                  alignment: Alignment(0, 0),
                                  height: 60,
                                  width: 150,
                                  margin: EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Category ${allCatProducts[index].id}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                      Text("Name: ${allCatProducts[index].name}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    ],
                                  ),

                                ),
                            );
                          }),
                    ) : Center(
                      child: Text(
                        "Error !!!",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text("ALl Products", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                    SizedBox(height: 15,),
                    ListView.builder(itemCount: allProducts.length, shrinkWrap: true, itemBuilder: (context, index){
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
                              allProducts[index].image ?? "",
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
                                    allProducts[index].name ?? "",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Category Id: ${allProducts[index].categoryId}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Price: \$${allProducts[index].price}",
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
                      );
                    })
                  ],
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

      }),
    );
  }
}
