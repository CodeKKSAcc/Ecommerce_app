import 'package:ecommerce_app/data/models/cart_product_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page/cart_bloc/cart_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page/cart_bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  /*List<String> images = [
    "asset/icons/shirt.png",
    "asset/icons/jacket.png",
    "asset/icons/jeans.png",
  ];*/

  TextEditingController couponController = TextEditingController();

  num subTotal = 0;
  num total = 0;

  bool isTapped = false;

  int itemTypes = 0;

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchAllCartItemEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        actions: [
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.remove_shopping_cart),
                SizedBox(width: 9),
                Text(
                  "Empty Cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment(0, -1),
            child: BlocConsumer<CartBloc, CartState>(
              listener: (context, state) {
                if (state is CartFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMsg),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (state is CartSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.successMsg),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                }

                if (state is CartFailureState) {
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

                if (state is CartLoadedState) {
                  List<CartProductModel> allProducts = state.allProductsInCart;

                  itemTypes = allProducts.length;

                  return allProducts.isNotEmpty
                      ? Stack(
                          children: [
                            Align(
                              alignment: Alignment(0, -1),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    itemCount: allProducts.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      total = 0;
                                      subTotal = 0;

                                      print("-------------------");
                                      print("Total : $total");
                                      print("Subtotal : $subTotal");
                                      print("Length : ${allProducts.length}");

                                      for (
                                        int i = 0;
                                        i < allProducts.length;
                                        i++
                                      ) {
                                        subTotal =
                                            subTotal +
                                            allProducts[i].quantity *
                                                num.parse(allProducts[i].price);

                                        total =
                                            total +
                                            allProducts[i].quantity *
                                                num.parse(allProducts[i].price);
                                      }

                                      print("-------------------");
                                      print("Total : $total");
                                      print("Subtotal : $subTotal");
                                      print("Length : ${allProducts.length}");

                                      return Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 9,
                                          vertical: 15,
                                        ),
                                        margin: EdgeInsets.only(
                                          top: 15,
                                          right: 15,
                                          left: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(
                                            21,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              allProducts[index].image,
                                              height: 90,
                                              width: 90,
                                              fit: BoxFit.fill,
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        allProducts[index].name,
                                                        style: TextStyle(
                                                          fontSize: 21,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 90,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                  CartBloc
                                                                >()
                                                                .add(
                                                                  DeleteCartEvent(
                                                                    cart_id:
                                                                        allProducts[index]
                                                                            .id,
                                                                  ),
                                                                );
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors
                                                              .deepOrangeAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    allProducts[index].name,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "\$${allProducts[index].price}",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 9,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 120,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 9,
                                                              vertical: 3,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                30,
                                                              ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            StatefulBuilder(
                                                              builder: (context, S) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (allProducts[index]
                                                                            .quantity >=
                                                                        1) {
                                                                      context
                                                                          .read<
                                                                            CartBloc
                                                                          >()
                                                                          .add(
                                                                            CartItemNumberEvent(
                                                                              product_id: allProducts[index].product_id,
                                                                              quantity: 1,
                                                                            ),
                                                                          );
                                                                      allProducts[index]
                                                                          .quantity++;
                                                                      setState(
                                                                        () {},
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                            Text(
                                                              allProducts[index]
                                                                  .quantity
                                                                  .toString(),
                                                            ),
                                                            StatefulBuilder(
                                                              builder: (context, S) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (allProducts[index]
                                                                            .quantity >=
                                                                        1) {
                                                                      context
                                                                          .read<
                                                                            CartBloc
                                                                          >()
                                                                          .add(
                                                                            CartItemNumberEvent(
                                                                              product_id: allProducts[index].product_id,
                                                                              quantity: -1,
                                                                            ),
                                                                          );
                                                                      allProducts[index]
                                                                          .quantity++;
                                                                      setState(
                                                                        () {},
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons.add,
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      /*return Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 9,
                                        vertical: 15,
                                      ),
                                      margin: EdgeInsets.only(top: 15, right: 15, left: 15),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(21),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            images[index],
                                            height: 90,
                                            width: 90,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(width: 12),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Full Shirt(Mens)",
                                                    style: TextStyle(
                                                      fontSize: 21,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 90),
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.deepOrangeAccent,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Cloths",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "\$99.00",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 108),
                                                  Container(
                                                    width: 120,
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: 9,
                                                      vertical: 3,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(),
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Icon(Icons.remove),
                                                        Text("1"),
                                                        Icon(Icons.add),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );*/
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment(0, 1),
                              child: isTapped
                                  ? Container(
                                      height: 330,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(21),
                                          topLeft: Radius.circular(21),
                                        ),
                                        border: Border.all(),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 21,
                                            right: 21,
                                            left: 21,
                                            child: TextField(
                                              controller: couponController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xffF6F6F6),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText: "Enter Discount Code",
                                                hintStyle: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black54,
                                                ),
                                                suffixIcon: Padding(
                                                  padding: EdgeInsets.all(6),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {});
                                                    },
                                                    icon: Text(
                                                      "Apply",
                                                      style: TextStyle(
                                                        fontSize: 21,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.deepOrange,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 120,
                                            right: 15,
                                            left: 15,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Subtotal",
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                Text(
                                                  "$subTotal\$",
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 153,
                                            right: 15,
                                            left: 15,
                                            child: Divider(),
                                          ),
                                          Positioned(
                                            top: 177,
                                            right: 15,
                                            left: 15,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Total",
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "$total\$",
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment(0, 0.93),
                                            child: InkWell(
                                              onTap: () {
                                                /*for(int i = 0; i<itemTypes; i++){
                                                  context.read<CartBloc>().add(OrderCartEvent(product_id: allProducts[itemTypes].product_id));
                                                }*/

                                                context.read<CartBloc>().add(
                                                  OrderCartEvent(
                                                    product_id: allProducts[0]
                                                        .product_id,
                                                  ),
                                                );

                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: Container(
                                                alignment: Alignment(0, 0),
                                                height: 63,
                                                width: double.infinity,
                                                margin: EdgeInsets.only(
                                                  right: 15,
                                                  left: 15,
                                                  bottom: 15,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      Colors.deepOrangeAccent,
                                                  // border: Border.all(style: BorderStyle.none),
                                                  borderRadius:
                                                      BorderRadius.circular(54),
                                                ),
                                                child: Text(
                                                  "Checkout",
                                                  style: TextStyle(
                                                    fontSize: 27,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment(0, 0.93),
                                      child: InkWell(
                                        onTap: () {
                                          isTapped = !isTapped;
                                          setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment(0, 0),
                                          height: 63,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                            right: 15,
                                            left: 15,
                                            bottom: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            // border: Border.all(style: BorderStyle.none),
                                            borderRadius: BorderRadius.circular(
                                              54,
                                            ),
                                          ),
                                          child: Text(
                                            "Checkout",
                                            style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                            "Cart Is Empty !!!",
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
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
