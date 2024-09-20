import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zioks_application/pages/CheckInPhone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zioks_application/pages/user_photo.dart';

class CheckInOTP extends StatefulWidget {
  const CheckInOTP({super.key});

  @override
  State<CheckInOTP> createState() => _CheckInOTPState();
}

class _CheckInOTPState extends State<CheckInOTP> {
  final TextEditingController _controller = TextEditingController();

  void _input(String text) {
    setState(() {
      _controller.text += text; // Append the tapped number to the TextField
    });
  }

  void _backspace() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _controller.text = _controller.text.substring(0, _controller.text.length - 1); // Remove the last character
      }
    });
  }

  void _done() {
    print("Done with number: ${_controller.text}");
    // Handle the done action, such as submitting the phone number or navigating
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _CheckIn(screenWidth, screenHeight),
            _BorderButton(screenWidth, screenHeight),
            _KeyPad(screenWidth * 0.6, screenHeight * 0.6),
          ],
        ),
      ),
    );
  }

  Widget _CheckIn(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.06),
              child: Text(
                'Check-In',
                style: TextStyle(
                  color: Color.fromRGBO(0, 176, 147, 1),
                  fontSize: screenWidth * 0.08,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(
                'Please enter OTP sent to: +91 9133056036',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.045,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  width: screenWidth * 0.1,
                  height: screenHeight * 0.06,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '', // Placeholder for the OTP digit
                      style: TextStyle(fontSize: screenWidth * 0.06),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _BorderButton(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.06,
              width: screenWidth * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromRGBO(0, 176, 147, 1), width: 2),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Row(
                    children: [
                      Text(
                        'Refresh in',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      Icon(
                        Icons.refresh,
                        color: Colors.black,
                        size: screenWidth * 0.03,
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        '4s',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            GestureDetector(
              onTap: () {
                // Navigate to UserPhoto page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPhoto()),
                );
              },
              child: Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.4,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 176, 147, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Row(
                      children: [
                        Text(
                          'Proceed Unverified',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: screenWidth * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _KeyPad(double containerWidth, double containerHeight) {
    return Padding(
      padding: EdgeInsets.only(top: containerHeight * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1', containerWidth),
              _buildButton('2', containerWidth),
              _buildButton('3', containerWidth),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4', containerWidth),
              _buildButton('5', containerWidth),
              _buildButton('6', containerWidth),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7', containerWidth),
              _buildButton('8', containerWidth),
              _buildButton('9', containerWidth),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('⌫', containerWidth, onPressed: _backspace),
              _buildButton('0', containerWidth),
              _buildButton('√', containerWidth, onPressed: _done),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, double containerWidth, {VoidCallback? onPressed}) {
    double buttonSize = containerWidth * 0.2; // Button size as 25% of container width
    return Padding(
      padding: EdgeInsets.only(top: containerWidth * 0.05),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        margin: EdgeInsets.all(containerWidth * 0.02),
        child: ElevatedButton(
          onPressed: onPressed ?? () => _input(text),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(buttonSize * 0.3),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: TextStyle(
                fontSize: buttonSize * 0.4,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}