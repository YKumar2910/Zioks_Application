import 'package:flutter/material.dart';
import 'pages/user_photo.dart';
<<<<<<< HEAD
import 'package:zioks_application/pages/opening_page.dart';
=======
import 'pages/purposepage.dart';
import 'pages/deatilspage.dart';
>>>>>>> 32ce5c1b59cc089bcc9b0f42fd9e3c825fd29a04
import 'package:zioks_application/pages/confirmation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
<<<<<<< HEAD
      home: OpeningPage());
=======
      home: Details(),);
>>>>>>> 32ce5c1b59cc089bcc9b0f42fd9e3c825fd29a04
  }
}