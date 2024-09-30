import 'package:flutter/material.dart';

class TokenProvider extends ChangeNotifier {
  late String _token;
  void setToken(String token){
    _token=token;
    notifyListeners();
  }
  String getToken(){
    return _token;
  }
}