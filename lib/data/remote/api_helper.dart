import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as HttpClient;
import 'package:wallpaper_app/data/remote/urls.dart';

import 'app_exceptions.dart';

class ApiHelper {
  Future<dynamic> getAPI({required String url}) async{
   // var uri = Uri.parse(url);

    try{
      var res = await HttpClient.get(Uri.parse(url), headers: {
        "Authorization" : AppUrls.API_KEY
      });
      return returnJsonResponse(res);
    }on SocketException catch (e) {
      throw(FetchDataException(errorMsg: "No Internet!!!"));

    }
  }

  dynamic returnJsonResponse(HttpClient.Response response){
    switch(response.statusCode){
      case 200: 
      {
        var mData = jsonDecode(response.body);
        return mData;
      }
      case 400:
      
        throw BadRequestException(errorMsg: response.body.toString());
        case 401: 
        case 403:
        throw UnauthorisedException(errorMsg: response.body.toString());
        case 500:
        default:
        throw FetchDataException(
           errorMsg: 'Error occurred while Communication with server'
        );
      
    }
  }
}