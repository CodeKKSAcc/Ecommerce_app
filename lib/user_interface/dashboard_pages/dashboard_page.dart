import 'package:ecommerce_app/app_utilities/app_constants/app_routes.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/home_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/profile_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wish_list_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Widget> pages = [
    ProductPage(),
    WishlListPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  int selectedPage = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (value) {
          if (value == 0) {
            Navigator.pushNamed(context, AppRoutes.product_page);
          }
          else if (value == 1) {
            Navigator.pushNamed(context, AppRoutes.wish_list_page);
          } else if (value == 3) {
            Navigator.pushNamed(context, AppRoutes.cart_page);
          } else {
            selectedPage = value;
          }
          setState(() {});
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        iconSize: 33,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize_outlined),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.home)
            /*FloatingActionButton(
              onPressed: () {},
              shape: CircleBorder(),
              backgroundColor: Colors.deepOrangeAccent,
              foregroundColor: Colors.white,
              child: Icon(Icons.home),
            )*/,
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
