import 'package:flutter/material.dart';
import 'package:zioks_application/const_values_file.dart';
import 'package:zioks_application/pages/opening_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
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
                    itemCount: widget.lines.length,
                    itemBuilder: (context,index){
          
                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          index==0?"Hi ${widget.lines[index]}":widget.lines[index],
                          style: TextStyle(
                            fontSize: index==0?fontSizeTextLarge :fontSizeTextSmall,
                            color: index==0?Colors.blueGrey.shade300:Colors.black,
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
                  child: Image(
                    height: imageHeight,
                    width: imageWidth,
                    image: AssetImage(
                      imageMapper['personsImage'] as String
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.teal.shade400,
                    fixedSize: Size(buttonWidth,buttonHeight ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.5))
                    )
          
                  ),
                  onPressed: (){
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
      ),

    );
  }
}

/* */