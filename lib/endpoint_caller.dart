import 'dart:convert';

import 'package:http/http.dart' as http;
class EndpointCaller {
  static const String _url='https://lab.stagingit.net/vms/backend/api/visitors/';
  static Future<Map<String,dynamic>> postCallEndpoint(String endpoint,Map<String,dynamic> data) async{
    
    try {
      final res=await http.post(Uri.parse(_url+endpoint),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data)
      );
      final resDecode=jsonDecode(res.body);
      if(resDecode["statusCode"]!=200){
          print(resDecode['Wrong OTP']);
      }
      return resDecode; 
      } on Exception catch (e) {
        throw e.toString();
    }
  }
  static Future<Map<String,dynamic>> getCallEndpoint(String endpoint, String token) async{
    try {
      final res=await http.get(Uri.parse(_url+endpoint),
      headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Optional, depending on API needs
      },
      );
      final resDecode=jsonDecode(res.body);
      if(resDecode["statusCode"]!=200){
          throw resDecode['message'];
      }
      return resDecode; 
      } on Exception catch (e) {
        throw e.toString();
    }
  }
}