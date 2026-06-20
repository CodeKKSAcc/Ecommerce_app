
import 'dart:async';

import 'package:ecommerce_app/app_utilities/app_constants/app_constants.dart';
import 'package:ecommerce_app/app_utilities/app_constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async{

      String nextPage = "";

      SharedPreferences myPref = await SharedPreferences.getInstance();
      String userToken = myPref.getString(AppUserConstants.user_token) ?? "";

      if(userToken.isNotEmpty){
        nextPage = AppRoutes.dashboard_page;
      } else{
        nextPage = AppRoutes.login_page;
      }
      Navigator.pushReplacementNamed(context, nextPage);
  }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(36)),
              shadowColor: Colors.deepOrangeAccent,
              elevation: 21,
              child: Icon(Icons.shopping_cart, size: 72),
            ),
            SizedBox(width: 15),
            Text(
              "Ecommerce App",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.deepOrange.shade300),
            ),
          ],
        ),
      ),
    );
  }
}