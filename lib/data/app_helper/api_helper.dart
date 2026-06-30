import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/app_utilities/app_constants/app_constants.dart';
import 'package:ecommerce_app/data/app_helper/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {

  Future<dynamic> getAPI({required String url, Map<String, String>? myHeaders}) async{

    try {

      myHeaders ??= {};

      SharedPreferences myPref = await SharedPreferences.getInstance();
      String token = myPref.getString(AppUserConstants.user_token) ?? "";
      myHeaders["Authorization"] = "Bearer $token";

      http.Response getResp = await http.get(Uri.parse(url), headers: myHeaders,);

      return apiResponse(getResp);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.message);
    } catch (e) {
      throw FetchDataException(msg: e.toString());
    }
  }

  Future<dynamic> postAPI({required String url, Map<String, dynamic>? myBodyParameters, bool isAuth = false, Map<String, String>? myHeaders
  }) async {
    try {

      if(!isAuth){
        //myHeaders = myHeaders ?? {} ;
        myHeaders ??= {} ;

        SharedPreferences myPref = await SharedPreferences.getInstance();
        String token = myPref.getString(AppUserConstants.user_token) ?? "";
        myHeaders["Authorization"] = "Bearer $token";
      }

      http.Response resp = await http.post(
        Uri.parse(url),
        body: jsonEncode(myBodyParameters),
        headers: myHeaders
      );
      return apiResponse(resp);
    } on SocketException catch (e) {
      // Internet not available
      throw NoInternetException(msg: e.message);
    } catch (e) {
      // Any other exception
      throw FetchDataException(msg: e.toString());
    }
  }

  dynamic apiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          dynamic data = jsonDecode(response.body);
          return data;
        }
      case 401:
      case 403:
        {
          throw UnauthorizedException(msg: response.body.toString());
        }
      case 404:
        {
          throw NotFoundException(msg: response.body.toString());
        }
      case 500:
        {
          throw ServerException(msg: response.body.toString());
        }
      default:
        {
          throw FetchDataException(msg: response.body.toString());
        }
    }
  }
}
