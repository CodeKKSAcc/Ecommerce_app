import 'package:ecommerce_app/app_utilities/app_constants/app_routes.dart';
import 'package:ecommerce_app/data/models/user_profile_data_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page/cart_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_category/category_display_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/home_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/user_profile/profile_bloc/profile_state.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/user_profile/profile_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wish_list_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_utilities/app_constants/app_constants.dart';
import 'app_pages/user_profile/profile_bloc/profile_bloc.dart';
import 'app_pages/user_profile/profile_bloc/profile_event.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();
    initialProfileFetch();
    context.read<ProductBloc>().add(FetchAllProductEvent());
  }

  Future<void> initialProfileFetch() async {
    context.read<ProfileBloc>().add(FetchAllProfileDataEvent());

      SharedPreferences myUid = await SharedPreferences.getInstance();
      myUid.setInt(AppUserConstants.user_id, 242);

    setState(() {});
  }

  List<Widget> pages = [
    CategoryDisplayPage(),
    WishListPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  int selectedPage = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      /*backgroundColor: Colors.blue,*/
      bottomNavigationBar: selectedPage == 3? null : BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  selectedPage = 0;
                });
              },
              icon: Icon(
                Icons.dashboard_customize_outlined,
                size: 27,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedPage = 1;
                });
              },
              icon: Icon(
                Icons.favorite,
                size: 27,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 51,),
            IconButton(
              onPressed: () {
                Navigator
                .pushNamed(context, AppRoutes.cart_page);
                setState(() {

                });
              },
              icon: Icon(
                Icons.shopping_cart,
                size: 27,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () async{
                /*SharedPreferences myPref = await SharedPreferences.getInstance();
                myPref.setInt(AppUserConstants.user_id, int.parse(userdata.id));
                print(int.parse(userdata.id));*/
                setState(() {
                  selectedPage = 4;
                });
              },
              icon: Icon(
                Icons.person,
                size: 27,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 72,
        width: 72,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              selectedPage = 2;
            });
          },
          shape: CircleBorder(),
          backgroundColor: Colors.deepOrangeAccent,
          foregroundColor: Colors.white,
          child: Icon(Icons.home, size: 36,),
        ),
      ),
      floatingActionButtonLocation: selectedPage == 3? null :  FloatingActionButtonLocation.centerDocked,
    );
  }
}
