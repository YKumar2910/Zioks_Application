import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  final TextEditingController cont;
  final String message;
  String? Function(String?)? validator;
  
  final dynamic emptyMessage;
  TextFieldWidget({
    super.key, 
    required this.message,
    required this.cont, 
    this.validator,
    required this.emptyMessage
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
              controller: cont,
              decoration:  InputDecoration(
                      hintText: (message), 
                      hintStyle:  const TextStyle(
                        color: Colors.grey
                      ),
                    ),
              keyboardType: TextInputType.text,
              validator: validator?? (value){
                if(value==null || value.isEmpty){
                  return emptyMessage;
                }
                return null;
              },
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

