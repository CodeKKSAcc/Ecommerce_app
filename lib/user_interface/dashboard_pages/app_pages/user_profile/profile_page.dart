import 'dart:io';

import 'package:ecommerce_app/app_utilities/app_constants/app_constants.dart';
import 'package:ecommerce_app/app_utilities/app_constants/app_routes.dart';
import 'package:ecommerce_app/data/models/user_profile_data_model.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/user_profile/profile_bloc/profile_bloc.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/user_profile/profile_bloc/profile_event.dart';
import 'package:ecommerce_app/user_interface/dashboard_pages/app_pages/user_profile/profile_bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../user_orders/order_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int id = 0;

  File? selectedImg;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async{

    SharedPreferences myPref = await SharedPreferences.getInstance();
    id = myPref.getInt(AppUserConstants.user_id) ?? 0;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is LoadingProfileState) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }

            if (state is FailureProfileState) {
              return Center(
                child: Text(
                  state.errorMsg,
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                ),
              );
            }

            if (state is LoadedProfileState) {
              UserProfileDataModel userdata = state.profileData;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  // Profile
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(0, 0),
                              child: Container(
                                height: 108,
                                width: 108,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadiusGeometry.circular(
                                    54,
                                  ),
                                  image: selectedImg != null
                                      ? DecorationImage(
                                    image: FileImage(selectedImg!),
                                    fit: BoxFit.cover,
                                  )
                                      : null,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment(1, 0.9),
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  onTap: ()async {
                                    /*showModalBottomSheet(context: context, builder: (context){
              return Container(
                color: Colors.deepPurple,
              );*/
                                    XFile? myImage = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    if (myImage != null) {
                                      CroppedFile? croppedFile = await ImageCropper().cropImage(
                                        sourcePath: myImage.path,
                                        uiSettings: [
                                          AndroidUiSettings(
                                            lockAspectRatio: true,
                                            initAspectRatio: CropAspectRatioPreset.square,
                                            showCropGrid: true,
                                            statusBarLight: true,
                                          ),
                                          IOSUiSettings(
                                            aspectRatioLockEnabled: true,
                                            aspectRatioPresets: [CropAspectRatioPreset.square],
                                            minimumAspectRatio: 1,
                                            showActivitySheetOnDone: true,
                                            showCancelConfirmationDialog: true,
                                          ),
                                          WebUiSettings(context: context),
                                        ],
                                      );

                                      if (croppedFile != null) {
                                        selectedImg = File(croppedFile.path);
                                        setState(() {});
                                      }
                                    }
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.green,
                                    size: 21,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 21),
                  Text(
                    "Personal Details",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 27),
                  Row(
                    children: [
                      Icon(Icons.person, size: 39, color: Colors.black),
                      SizedBox(width: 45),
                      Text(
                        userdata.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.mail, size: 39, color: Colors.black),
                      SizedBox(width: 45),
                      Text(
                        userdata.email,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.call, size: 39, color: Colors.black),
                      SizedBox(width: 45),
                      Text(
                        userdata.mobile_number,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.insert_drive_file, size: 39, color: Colors.black),
                      SizedBox(width: 45),
                      Text(
                        "$id",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 21),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderPage()));
                    },
                    child: Container(
                      alignment: Alignment(-0.72, 0),
                      height: 63,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide()),
                      ),
                      child: Text(
                        "Orders",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.cart_page);
                    },
                    child: Container(
                      alignment: Alignment(-0.72, 0),
                      height: 63,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide()),
                      ),
                      child: Text(
                        "View Cart",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences myPref =
                          await SharedPreferences.getInstance();
                      await myPref.remove(AppUserConstants.user_token);

                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.login_page,
                      );
                    },
                    child: Container(
                      alignment: Alignment(-0.72, 0),
                      height: 63,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(), bottom: BorderSide()),
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: Text(
                "Unknown Error",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
              ),
            );
          },
        ),
      ),
    );
  }
}
