import 'package:flutter/material.dart';
import 'package:zioks_application/image_mapper.dart';
import 'package:zioks_application/pages/confirmation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Zioks-CheckApplication",
      home: ConfirmationPage(text: "Kshitij Jaiswal \n $exitnote"),
    );
  }
}