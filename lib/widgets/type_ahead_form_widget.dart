import 'dart:async';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:zioks_application/pages/visitor_info.dart'; 

// ignore: must_be_immutable
class AutoTextField extends StatelessWidget {
  
  final TextEditingController cont;
  final String message;
  
  Icon? icon;
  double? fontSize;
  
  bool? align=false;
  AutoTextField({
    super.key, 
    required this.message,
    required this.cont, 
    
    this.icon,
    required this.fontSize,
    this.align
  });

  final List<String> suggestionsList = [
    "Apple",
    "Samsung",
    "Motorola",
    "CodeClouds",
    "Cognizant",
    "Accenture",
    "Hiver",
    "Zioks",
    "Pwc",
    "SAP",
  ];
  Future<List<String>> getMatches(String pattern) async{
    List<String> matches=[];
    matches.addAll(suggestionsList);
    matches.retainWhere((s)=>s.toLowerCase().contains(pattern.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {

    return TypeAheadField<String>(
      hideOnEmpty: true,
      
      builder: (context,controller,focusNode){
        return TextField(
          controller: controller,
          textAlign: align==true?TextAlign.center:TextAlign.left,
          decoration:  InputDecoration(
            alignLabelWithHint: true,
            prefixIcon: icon,
            hintText:message
          ),
          focusNode: focusNode,
          autofocus: true,
        );
      },
      suggestionsCallback: (pattern) async {
        if (pattern.length >= 3) {
          return await getMatches(pattern);
        } else{
          return [];
        }
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(
            suggestion,
            style: TextStyle(fontSize: fontSize),
          ),
        );
      },
      
      onSelected: (suggestion) {
        cont.text = suggestion;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return const VisitorInfo();
          }));
      },
    );
  }
}
