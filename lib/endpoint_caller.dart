// import 'dart:convert';

// import 'package:http/http.dart' as http;
// class EndpointCaller {
//   static const String _url='https://lab.stagingit.net/vms/backend/api/visitors/';
//   static Future<Map<String,dynamic>> postCallEndpoint({required String endpoint,required Map<String,dynamic>? data, String? token, String? contentType}) async{
    
//     try {
//       final res=await http.post(Uri.parse(_url+endpoint),
//         headers: {
//           'Authorization': token!=null?'Bearer $token':"",
//           'Content-Type': contentType??'application/json'
//         },
//         body: contentType=='application/json'?jsonEncode(data):data
//       );
//       final resDecode=jsonDecode(res.body);
//       if(resDecode["statusCode"]!=200){
//           print(resDecode['Wrong OTP']);
//       }
//       return resDecode; 
//       } on Exception catch (e) {
//         throw e.toString();
//     }
//   }
//   static Future<Map<String,dynamic>> getCallEndpoint({required String endpoint,required String token, String? contentType}) async{
//     try {
//       final res=await http.get(Uri.parse(_url+endpoint),
//       headers: {
//       'Authorization': 'Bearer $token',
//       'Content-Type': contentType??'application/json'
//       },
//       );
//       final resDecode=jsonDecode(res.body);
//       if(resDecode["statusCode"]!=200){
//           throw resDecode['message'];
//       }
//       return resDecode; 
//       } on Exception catch (e) {
//         throw e.toString();
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class EndpointCaller {
  static const String _url = 'https://lab.stagingit.net/vms/backend/api/visitors/';

  static Future<Map<String, dynamic>> postCallEndpoint({
    required String endpoint,
    Map<String, dynamic>? data,
    String? token,
    String? contentType,
    File? imageFile, // Optional image file for multipart
  }) async {
    try {
      // Handle multipart/form-data for file uploads
      if (contentType == 'multipart/form-data' && imageFile != null) {
        var uri = Uri.parse(_url + endpoint);
        var request = http.MultipartRequest('POST', uri);

        // Add token if present
        if (token != null && token.isNotEmpty) {
          request.headers['Authorization'] = 'Bearer $token';
        }

        // Add image file to request
        var multipartFile = await http.MultipartFile.fromPath('image', imageFile.path);
        request.files.add(multipartFile);

        // Add other data if present
        if (data != null) {
          data.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }

        // Send request and get response
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);
        return jsonDecode(response.body);
      } 
      
      // Handle JSON request
      else {
        final res = await http.post(
          Uri.parse(_url + endpoint),
          headers: {
            'Authorization': token != null ? 'Bearer $token' : "",
            'Content-Type': contentType ?? 'application/json',
          },
          body: jsonEncode(data),
        );
        
        final resDecode = jsonDecode(res.body);
        if (res.statusCode != 200) {
          print(resDecode['message'] ?? 'Error');
        }
        return resDecode;
      }
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  static Future<Map<String, dynamic>> getCallEndpoint({
    required String endpoint,
    required String token,
    String? contentType,
  }) async {
    try {
      final res = await http.get(
        Uri.parse(_url + endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': contentType ?? 'application/json',
        },
      );
      final resDecode = jsonDecode(res.body);
      if (res.statusCode != 200) {
        throw resDecode['message'];
      }
      return resDecode;
    } on Exception catch (e) {
      throw e.toString();
    }
  }
}
