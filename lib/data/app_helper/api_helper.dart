import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/data/app_helper/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  void getAPI({required String url}) {}

  Future<dynamic> postAPI({required String url, Map<String, dynamic>? myBodyParameters}) async {
    try {
      http.Response resp = await http.post(Uri.parse(url), body: jsonEncode(myBodyParameters));
      return apiResponse(resp);
    } on SocketException catch (e) {
      // Internet not available
      throw NoInternetException(msg: e.message);
    } catch (e) {
      // Any other exception
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
