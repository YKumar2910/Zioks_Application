import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  late String _accessToken;
  void setaccessToken(String token){
    _accessToken=token;
    notifyListeners();
  }
  void deleteAccessToken(){
    _accessToken="";
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
  void deleteRefreshToken(){
    _refreshToken="";
    notifyListeners();
  }
  String getrefreshToken(){
    return _refreshToken;
  }
  late dynamic _alreadyExist;
  void setalreadyExist(dynamic isverified){
    _alreadyExist=isverified;
    notifyListeners();
  }
  dynamic getalreadyExist(){
    return _alreadyExist;
  }
  late dynamic otp;
  void setOTP(dynamic otp){
    this.otp=otp;
    notifyListeners();
  }
  void deleteOTP(){
    this.otp="";
    notifyListeners();
  }
}