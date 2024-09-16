import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:zioks_application/image_mapper.dart';
import 'package:zioks_application/pages/confirmation_page.dart';
=======
import 'user_photo.dart';
>>>>>>> d27f422055660f039c7e05b8e66dd1095e952ac4

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      title: "Zioks-CheckApplication",
      home: ConfirmationPage(text: "Kshitij Jaiswal\n$exitnote"),
=======
    return  MaterialApp(
      home: UserPhoto(),
>>>>>>> d27f422055660f039c7e05b8e66dd1095e952ac4
    );
  }
}