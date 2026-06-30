import 'package:ecommerce_app/app_utilities/app_constants/app_routes.dart';
import 'package:ecommerce_app/data/app_helper/api_helper.dart';
import 'package:ecommerce_app/data/app_helper/database_helper.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/cart_page/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/product_category/category_bloc/category_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/user_profile/profile_bloc/profile_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/wishlist_products/wishlist_bloc/wishlist_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/products_bloc/product_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/user_orders/order_bloc/order_bloc.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc(apiHelper: ApiHelper())),
        BlocProvider(create: (context) => ProductBloc(apiHelper: ApiHelper())),
        BlocProvider(create: (context) => ProfileBloc(apiHelper: ApiHelper())),
        BlocProvider(create: (context) => CartBloc(apiHelper: ApiHelper())),
        BlocProvider(create: (context) => OrderBloc(apiHelper: ApiHelper())),
        BlocProvider(create: (context) => WishlistBloc(databaseHelper: DatabaseHelper.onlyInstance())),
        BlocProvider(create: (context) => CategoryBloc(apiHelper: ApiHelper())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget { // String isn't s subtype of bool
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash_page,
      routes: AppRoutes.pageRoute,
      title: "Ecommerce App",
    );
  }
}
