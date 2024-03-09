import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'base_network.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApi(String url) async{
    dynamic responseJson ;
    try {
      final response= await http.get(Uri.parse(url));
      responseJson  = jsonDecode(response.body.toString()) ;
      print(responseJson);
    }on SocketException {
      throw Future.error("Error");
    }
    return responseJson ;
  }
}