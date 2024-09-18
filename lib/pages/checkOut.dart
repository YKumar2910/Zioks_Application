import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
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
            _Checkout(screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _ZioksName(double screenWidth, double screenHeight) {
    return Align(
      alignment: Alignment.topCenter, // Horizontally center and move to top
      child: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05, // Adjust top padding based on screen height
          left: screenWidth * 0.1, // Adjust left padding based on screen width
          right: screenWidth * 0.1, // Adjust right padding based on screen width
        ),
        child: SvgPicture.asset(
          "assets/images/zioks-color (1).svg", // Ensure correct file name
          width: screenWidth * 0.5, // Adjust width based on screen width
          height: screenHeight * 0.25, // Adjust height based on screen height
        ),
      ),
    );
  }

  Widget _WelcomeToZioks(double screenWidth) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05), // Adjust padding based on screen width
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

  Widget _Checkout(double screenWidth) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.05), // Adjust padding based on screen width
      child: Text(
        "This is the CheckOut Page",
        style: TextStyle(
          fontSize: screenWidth * 0.08, // Adjust font size based on screen width
          color: Color.fromRGBO(0, 176, 147, 1),
          fontFamily: 'Sen',
        ),
      ),
    );
  }
}
