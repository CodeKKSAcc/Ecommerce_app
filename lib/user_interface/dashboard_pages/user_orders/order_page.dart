import 'package:ecommerce_app/data/models/order_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/user_orders/order_bloc/order_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/user_orders/order_bloc/order_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/user_orders/order_bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(FetchAllOrderEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Page"),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
        if (state is LoadingOrderState) {
          return Center(child: CircularProgressIndicator(color: Colors.blue,));
        }

        if (state is ErrorOrderState) {
          return Text(
            state.errorMsg,
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
          );
        }

        if (state is LoadedOrderState) {
          List<OrderModel> allOrders = state.allOrders;

          return allOrders.isNotEmpty ? ListView.builder(
              shrinkWrap: true,
              itemCount: allOrders.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  margin: EdgeInsets.only(top: 12, right: 15, left: 15),
                  decoration: BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all()
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Number: ${allOrders[index].order_number}", style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                      Text("Total Order Price: ${allOrders[index].total_amount}", style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                      Text("Order Id: ${allOrders[index].id}", style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
                      SizedBox(height: 15,),

                      ListView.builder(
                          itemCount: allOrders[index].product.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, indx){
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
                                    allOrders[index].product[indx].image,
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
                                    allOrders[index].product[indx].name,
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                        Text(
                                          "Quantity: ${allOrders[index].product[indx].quantity}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Price: \$${allOrders[index].product[indx].price}",
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
              }) : Center(
            child: Text(
              "Unknown Error",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
            ),
          );;
        }

        return Center(
          child: Text(
            "Unknown Error",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
          ),
        );
      }),
    );
  }
}
