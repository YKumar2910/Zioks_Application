import 'package:zioks_application/const_values_file.dart';
import 'package:flutter/material.dart';

class TenantWidgetCard extends StatelessWidget {
  final dynamic height;
  
  final dynamic width;
  
  final dynamic fontSize;


  const TenantWidgetCard({
    super.key,
    required this.height, 
    required this.width,
    required this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        borderOnForeground: true,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.transparent, 
            width: 0, 
          ),
          borderRadius: BorderRadius.circular(0),
        ),
        color: Colors.white,
        
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black, 
                  width: 2.0,
                ),
              ),
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Padding(
                 padding: const EdgeInsets.symmetric(vertical: 4),
                 child: Image(
                  height: height,
                  width: width,
                  image:AssetImage(
                    imageMapper["cloudNetwork"]
                  )
                 ),
               ),
               Text(
                "Tenant",
                style: TextStyle(
                  fontSize: fontSize>=height*.5?fontSize:height*.5,
                  fontWeight: FontWeight.w300
                ),
               ),
               Icon(Icons.arrow_forward, color: const Color.fromRGBO(0, 176, 147, 1),size: height*.5,weight: 10,)
            ],
          ),
        ),
      ),
    );
  }
}