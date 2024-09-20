import 'package:flutter/material.dart';
import 'package:zioks_application/pages/visitor_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: "Zioks-CheckApplication",
      home: VisitorInfo()
    );
  }
}