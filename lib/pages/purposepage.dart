// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zioks_application/routes.dart';
import 'package:zioks_application/token_provider.dart';
import 'package:zioks_application/widgets/custom_widget.dart';
import 'package:zioks_application/endpoint_caller.dart';

class Purpose extends StatefulWidget {
  @override
  _PurposeState createState() => _PurposeState();
}

class _PurposeState extends State<Purpose> {
  Map<String, dynamic>? purposeData;

  void didChangeDependencies() {
    super.didChangeDependencies();
    // Move the fetchPurposes logic here to avoid the error
    fetchPurposes().then((data) {
      setState(() {
        purposeData = data;
      });
    }).catchError((error) {
      throw Exception('Failed to load purpose: $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight*0.1,),

                HeaderWidget(message: 'Please select your purpose', screenWidth: screenWidth),

                SizedBox(height: screenHeight * 0.2),

                //Loader
                //purposeData == null ? CircularProgressIndicator(): ...purposeData!.entries.map((purpose) {
                  Column(
                    children: purposeData == null
                      ? [CircularProgressIndicator()]
                      : purposeData!.entries.map((entry) {
                          String purposeId = entry.key;
                          String purposeName = entry.value[0];
                          String lastActivity = entry.value[1];
                          
                          return Column(
                            children: [
                              buildCard(
                                label: purposeName,
                                onPressed: () {
                                  Navigator.pushNamed(context, MyRoutes.deatilspageRoute);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: 8),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Last Activity: $lastActivity', // Use the actual lastActivity variable
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 176, 147, 1),
                                      fontSize: screenWidth * 0.03,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.05),
                            ],
                          );
                        }).toList(),
                  ),  
                
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
              style: TextStyle(fontSize: screenWidth * 0.045, color: Color.fromRGBO(0, 176, 147, 1),),
            ),
            Icon(Icons.arrow_forward, color: Color.fromRGBO(0, 176, 147, 1), size: screenWidth*0.05,),
          ],
        ),
      ),
    );
  }

  //Function to fetch the purpose data from the api
Future<Map<String, dynamic>> fetchPurposes() async{
  try{
    String token= Provider.of<TokenProvider>(context).getaccessToken();
    final response = await EndpointCaller.getCallEndpoint('visit-purposes', token);
    print(response);
    return Map<String, dynamic>.from(response['data']);
  } catch (e) {
    throw Exception('Failed to load purpose: $e');
  }
}

}








                    // purposeData == null ? CircularProgressIndicator(): ...purposeData!.entries.map((purpose) {
                    // // children:
                    // String purposeId = entry.key;
                    // String purposeName = entry.value[0];
                    // String lastActivity = entry.value[1];
                    // [
                    //   buildCard(
                    //     label: purpose,
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, MyRoutes.deatilspageRoute);
                    //     },
                    //   ),
                    //   Padding(
                    //     padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05, top: 8), // Padding for the Last activity
                    //     child: Align(
                    //       alignment: Alignment.centerRight,
                    //       child: Text(
                    //         'Last Activity: 18-09-2024',
                    //         style: TextStyle(color: Color.fromRGBO(0, 176, 147, 1), fontSize: screenWidth*0.03),
                    //       ),
                    //     ),
                    //   ),
                    //   SizedBox(height: screenHeight * 0.05), // Spacing between Purpose cards
                    // ],}).toList(),