import 'package:flutter/material.dart';
import 'package:zioks_application/pages/confirmation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Zioks-CheckApplication",
      home: ConfirmationPage(text: " Kshitij Jaiswal\nThank you for visiting.."),
    );
  }
}