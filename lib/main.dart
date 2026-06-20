import 'package:ecommerce_app/app_utilities/app_constants/app_routes.dart';
import 'package:ecommerce_app/data/app_helper/api_helper.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    /*BlocProvider(
      create: (context) => UserBloc(apiHelper: ApiHelper()),
      child: const MyApp(),
    ),*/
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc(apiHelper: ApiHelper())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
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
