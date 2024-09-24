import 'package:flutter/material.dart';
import 'pages/user_photo.dart';
import 'pages/purposepage.dart';
import 'pages/deatilspage.dart';
import 'package:zioks_application/pages/confirmation_page.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Details(),
      
      initialRoute: MyRoutes.userphotoRoute,
      routes: {
      MyRoutes.userphotoRoute: (context) => UserPhoto(),
  },

      );
  }
}