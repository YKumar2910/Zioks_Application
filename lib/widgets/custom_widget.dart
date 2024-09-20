import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController cont;
  final String message;
  const TextFieldWidget({super.key, required this.message,required this.cont});

  @override
  Widget build(BuildContext context) {
    return TextField(
              controller: cont,
              decoration:  InputDecoration(
                      hintText: (message), 
                      hintStyle:  const TextStyle(
                        color: Colors.grey
                      ),
                    ),
              keyboardType: TextInputType.name,
            );
  }
}

class TextWidget extends StatelessWidget {
  
  final String message;
  final double fontsize;
  const TextWidget({super.key, required this.message,required this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: message,
            style: TextStyle(
              fontSize: fontsize,
              color: Colors.teal.shade400,
            ),
          ),
          TextSpan(
            text: "*",
            style: TextStyle(
              fontSize: fontsize,
              color: Colors.red,
            ),
          )
        ]
      )
    );
  }
}