import 'package:ecommerce_app/app_utilities/app_constants/app_routes.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_event.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  bool isLoading = false;

  GlobalKey<FormState> loginKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 27),
        child: Form(
          key: loginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Already have an account, Login!",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 54),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                  hintText: "Enter your email here...",
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (formValue) {
                  RegExp emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (formValue == null || formValue.isEmpty) {
                    return "Please enter your email...";
                  } else if (!emailRegex.hasMatch(formValue)) {
                    return "Please enter a valid email";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 18),
              StatefulBuilder(
                builder: (context, sS) {
                  return TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      hintText: "Enter your password here...",
                      labelText: "Password",
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isVisible = !isVisible;
                          sS(() {});
                        },
                        icon: isVisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                    obscureText: !isVisible,
                    obscuringCharacter: "*",
                    validator: (formValue) {
                      if (formValue == null || formValue.isEmpty) {
                        return "Please enter your password...";
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
              Expanded(child: SizedBox(height: 18)),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is LoadingUserState) {
                    isLoading = true;
                  }
                  if (state is FailureUserState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMsg),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is SuccessUserState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("User Login Successfully !!!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.dashboard_page,
                    );
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (loginKey.currentState!.validate()) {
                        context.read<UserBloc>().add(
                          LoginUserEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment(0, 0),
                      height: 63,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: BoxBorder.fromBorderSide(BorderSide.none),
                        borderRadius: BorderRadius.circular(21),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              isLoading
                                  ? "Varifying User Credentials"
                                  : "Login",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
              SizedBox(width: 18),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 9),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.signup_page,
                      );
                    },
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
