import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zioks_application/pages/CheckInPhone.dart';

class CheckInScanQR extends StatefulWidget {
  const CheckInScanQR({super.key});

  @override
  State<CheckInScanQR> createState() => _CheckInScanQRState();
}

class _CheckInScanQRState extends State<CheckInScanQR> {
  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _ZioksName(screenWidth, screenHeight),
            _WelcomeToZioks(screenWidth),
            _CheckIn(screenWidth, screenHeight),
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

  Widget _WelcomeToZioks(double screenWidth) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Text(
        "Welcome to ZIOKS",
        style: TextStyle(
          fontSize: screenWidth * 0.08, // Adjust font size based on screen width
          color: Colors.black,
          fontFamily: 'Sen',
        ),
      ),
    );
  }

  Widget _CheckIn(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.03),

          Text(
            "SCAN QR TO CHECK IN",
            style: TextStyle(
              fontSize: screenWidth * 0.06, // Adjust font size based on screen width
              color: Colors.black,
              fontFamily: 'Sen',
            ),
          ),

          SizedBox(height: screenHeight * 0.05),

          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey, // Border color
                width: 3, // Border width
              ),
            ),
            child: Image.asset(
              'assets/images/qr-code_714390.png', // Ensure correct file name
              width: screenWidth * 0.3, // Adjust size based on screen width
              height: screenHeight * 0.15, // Adjust size based on screen height
            ),
          ),

          SizedBox(height: screenHeight * 0.05), // Adjust the spacing based on screen height

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PhoneNumber()),
              );
            },
            child: Container(
              width: screenWidth * 0.4, // Adjust button size based on screen width
              height: screenHeight * 0.06, // Adjust button size based on screen height
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 176, 147, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Tap to Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05, // Adjust font size based on screen width
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}