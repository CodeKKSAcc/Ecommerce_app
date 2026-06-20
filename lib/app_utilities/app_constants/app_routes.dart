import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/home_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/profile_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wish_list_page.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/dashboard_page.dart';
import 'package:ecommerce_app/user_interface/on_boarding/login/login_page.dart';
import 'package:ecommerce_app/user_interface/on_boarding/signup/signup_page.dart';
import 'package:ecommerce_app/user_interface/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String splash_page = "splash";
  static String login_page = "login";
  static String signup_page = "signup";
  static String dashboard_page = "dashboard";
  static String home_page = "home";
  static String product_page = "product";
  static String wish_list_page = "wish_list";
  static String cart_page = "cart";
  static String profile_page = "profile";

  static Map<String, WidgetBuilder> pageRoute = {
    splash_page: (context) => SplashPage(),
    login_page : (context) => LoginPage(),
    signup_page : (context) => SignupPage(),
    dashboard_page: (context) => DashboardPage(),
    home_page: (context) => HomePage(),
    product_page: (context) => ProductPage(),
    wish_list_page: (context) => WishlListPage(),
    cart_page: (context) => CartPage(),
    profile_page: (context) => ProfilePage(),
  };
}
