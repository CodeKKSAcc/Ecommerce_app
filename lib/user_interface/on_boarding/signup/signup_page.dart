import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_event.dart';
import 'package:ecommerce_app/user_interface/on_boarding/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_utilities/app_constants/app_routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfPassVisible = false;

  bool isLoading = false;

  GlobalKey<FormState> signupKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 36),
        child: Form(
          key: signupKey,
          child: Column(
            children: [
              Text(
                "Don't have an account, Signup!",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 54),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                  hintText: "Enter your name here...",
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (formValue) {
                  if (formValue == null || formValue.isEmpty) {
                    return "Please enter your name...";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 18),
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
              TextFormField(
                controller: mobNoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                  hintText: "Enter your mobile number here...",
                  labelText: "Mobile No.",
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (formValue) {
                  if (formValue == null || formValue.isEmpty) {
                    return "Please enter your mobile number...";
                  }
                  if (formValue.length != 10) {
                    return "Please enter a valid mobile number";
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
                          isPasswordVisible = !isPasswordVisible;
                          sS(() {});
                        },
                        icon: isPasswordVisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                    obscuringCharacter: "#",
                    obscureText: !isPasswordVisible,
                    validator: (formValue) {
                      RegExp varifyPassword = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      );

                      if (formValue == null || formValue.isEmpty) {
                        return "Please enter your password...";
                      } else if (!varifyPassword.hasMatch(formValue)) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 18),
              StatefulBuilder(
                builder: (context, sS) {
                  return TextFormField(
                    controller: confirmPassController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
                      hintText: "Enter your password again...",
                      labelText: "Confirm Password",
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isConfPassVisible = !isConfPassVisible;
                          sS(() {});
                        },
                        icon: isConfPassVisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                    ),
                    obscuringCharacter: "#",
                    obscureText: !isConfPassVisible,
                    validator: (formValue) {
                      if (formValue != confirmPassController.text) {
                        return "Password hasn't matched";
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
              Expanded(child: SizedBox(height: 9)),
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
                        content: Text("User Created Successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pushReplacementNamed(context, AppRoutes.login_page);
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (signupKey.currentState!.validate()) {
                        context.read<UserBloc>().add(
                          SignupUserEvent(
                            name: nameController.text,
                            mobile_number: mobNoController.text,
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
                              isLoading ? "Creating an account !!!" : "Signup",
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
                        AppRoutes.login_page,
                      );
                    },
                    child: Text(
                      "Login",
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
