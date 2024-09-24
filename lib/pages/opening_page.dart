import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zioks_application/pages/checkInScanQR.dart';
import 'package:zioks_application/pages/checkOut.dart';
import 'package:zioks_application/routes.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({super.key});

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _ZioksName(screenWidth, screenHeight),
            _WelcomeToZioks(screenWidth, screenHeight),
            _CheckInCheckOut(screenWidth, screenHeight),
          ],
        ),
      ),
    );
  }

  Widget _ZioksName(double screenWidth, double screenHeight) {
    return Align(
      alignment: Alignment.topCenter, // Horizontally center and move to top
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.1, right: screenWidth * 0.1),
        child: SvgPicture.asset(
          "assets/images/zioks-color (1).svg", // Ensure correct file name
          width: screenWidth * 0.5, // Adjust size based on screen width
          height: screenHeight * 0.2, // Adjust size based on screen height
        ),
      ),
    );
  }

  Widget _WelcomeToZioks(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Text(
        "Welcome to ZIOKS",
        style: TextStyle(
          fontSize: screenWidth * 0.08, // Adjust font size based on screen width
          color: Color.fromRGBO(0, 176, 147, 1),
          fontFamily: 'Sen',
        ),
      ),
    );
  }

  Widget _CheckInCheckOut(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                MyRoutes.checkOutRoute
              );
            },

            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.14), // Flip image horizontally
              child: Image.asset(
                'assets/images/logout (1).png', // Use the same image as check-in
                width: screenWidth * 0.25, // Adjust size based on screen width
                height: screenHeight * 0.15, // Adjust size based on screen height
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.1),
          // Adjust space between icons
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckInScanQR()),
              );
            },
            child: Image.asset(
              'assets/images/logout (1).png', // Ensure correct file name
              width: screenWidth * 0.25, // Adjust size based on screen width
              height: screenHeight * 0.15, // Adjust size based on screen height
            ),
          ),
        ],
      ),
    );
  }
}
