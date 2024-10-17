import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  late String _accessToken;
  void setaccessToken(String token){
    _accessToken=token;
    notifyListeners();
  }
  String getaccessToken(){
    return _accessToken;
  }

  late String _refreshToken;
  void setrefreshToken(String token){
    _refreshToken=token;
    notifyListeners();
  }
  String getrefreshToken(){
    return _refreshToken;
  }

}