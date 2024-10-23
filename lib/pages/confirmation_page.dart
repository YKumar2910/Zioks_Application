import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zioks_application/endpoint_caller.dart';
import 'package:zioks_application/pages/opening_page.dart';
import 'package:zioks_application/token_provider.dart';
import 'package:zioks_application/widgets/custom_widget.dart';

// ignore: must_be_immutable
class ConfirmationPage extends StatefulWidget {
  late List<String> lines;
  final String text;

  ConfirmationPage({super.key,required this.text}) {
    lines=text.split(RegExp(r'\r?\n'));
  }

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  late Future<Map<String,dynamic>> visitorDetails;
  late String token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token=Provider.of<TokenProvider>(context,listen: false).getaccessToken();
    visitorDetails=EndpointCaller.getCallEndpoint(endpoint: "display-avatar", token: token);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: visitorDetails,
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          final response=snapshot.data!;
          print(response);
          widget.lines[0]="${response["data"]["firstName"]} ${response["data"]["lastName"]}";
          Uint8List bytes=base64Decode((response["data"]["image"] as String).split(',')[1]);
          return LayoutBuilder(
            builder: (context,constraints) {
              double screenWidth = constraints.maxWidth;
              double screenHeight = constraints.maxHeight;
          
              // Define breakpoints
              //double fontSizeTitle = screenWidth < 600 ? 24 : 30;
              double fontSizeTextLarge = screenWidth < 600 ? 30 : 40;
              double fontSizeTextSmall = screenWidth < 600 ? 18 : 25;
              double imageWidth = screenWidth < 600 ? screenWidth * 0.55 : 350;
              double imageHeight = screenWidth < 600 ? screenWidth * 0.6 : 300;
              double buttonWidth = screenWidth < 600 ? screenWidth * 0.5 : 300;
              double buttonHeight = screenWidth < 600 ? 50 : 75;
              final int noOflines=widget.lines.length;
          
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    HeaderWidget(
                      message: "Confirmation",
                      screenWidth: screenWidth,
                    ),
                    const Spacer(),
                    SizedBox(
                      height:screenHeight * 0.2,
                      child: ListView.builder(
                        itemCount: noOflines,
                        itemBuilder: (context,index){
                          bool con=(index==0);
                          return Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              con?"Hi ${widget.lines[index]}":widget.lines[index],
                              style: TextStyle(
                                fontSize: con?fontSizeTextLarge :fontSizeTextSmall,
                                color: con?Colors.blueGrey.shade300:Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300,width:4)
                      ),
                      child: Image.memory(
                        bytes,
                        height: imageHeight,
                        width: imageWidth,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 176, 147, 1),
                        fixedSize: Size(buttonWidth,buttonHeight ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.5))
                        )
                      ),
                      onPressed: () async{
                        Map<String,dynamic> response2= await EndpointCaller.postCallEndpoint(endpoint: "confirm-checkin",token: token);
                        print(response2);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context){
                              return const OpeningPage();
                            }
                          )
                        );
                      }, 
                      child: Text(
                        noOflines==1?"Confirm Check in":"Confirm Check out",
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 20 : 30,
                          color: Colors.white
                        ),
                      )
                    ),
                    const Spacer(flex:3),
                  ],
                  
                ),
              );
            }
          );
        }
      ),

    );
  }
}

/* */