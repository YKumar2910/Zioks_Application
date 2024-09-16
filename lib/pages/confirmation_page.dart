import 'package:flutter/material.dart';

class ConfirmationPage extends StatefulWidget {
  final String text;

  const ConfirmationPage({super.key,required this.text});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Confirmation",
              style: TextStyle(
                fontSize: 20,
                color: Colors.teal.shade300,
              ),
            ),
            const Spacer(flex:2),
            Text(
              "Hi ${widget.text}",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            const Spacer(flex:2),
            const Image(image: AssetImage("assets\freepik-export-20240822133548eLgG.jpeg"))
          ],

        ),
      ),

    );
  }
}