// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zioks_application/routes.dart';

class Purpose extends StatefulWidget {
  @override
  _PurposeState createState() => _PurposeState();
}

class _PurposeState extends State<Purpose> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<String> purposeList = ['Official', 'Vendor', 'Personal', 'Others'];//Dynamic list for the purpose of visit

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight*0.1,),
                Text(
                  'Please select your purpose',
                  style: TextStyle(fontSize: screenWidth * 0.06, color: Color.fromRGBO(0, 176, 147, 1)),
                ),
                SizedBox(height: screenHeight * 0.2),
                
                // Cards have been created dynamically using the list.
                ...purposeList.map((purpose) {
                  return Column(
                    children: [
                      buildCard(
                        label: purpose,
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.deatilspageRoute);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: 8), // Padding for the Last activity
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Last Activity: 18-09-2024',
                            style: TextStyle(color: Color.fromRGBO(0, 176, 147, 1), fontSize: screenWidth*0.03),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05), // Spacing between Purpose cards
                    ],
                  );  
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard({required String label, required VoidCallback onPressed}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(

          border: Border.all(color: Color.fromRGBO(0, 176, 147, 1), width: screenWidth*0.003),
          borderRadius: BorderRadius.circular(10),
        ),
        // Card width is 90% of screen width
        width: screenWidth * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.person, color: Color.fromRGBO(0, 176, 147, 1), size: screenWidth*0.08),
            Text(
              label,
              style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.teal,),
            ),
            Icon(Icons.arrow_forward, color: Color.fromRGBO(0, 176, 147, 1), size: screenWidth*0.05,),
          ],
        ),
      ),
    );
  }
}
