// ignore_for_file: use_build_context_synchronously

import 'package:provider/provider.dart';
import 'package:zioks_application/endpoint_caller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zioks_application/pages/user_photo.dart';
import 'package:zioks_application/widgets/custom_widget.dart';
import 'package:zioks_application/token_provider.dart';


class CheckInOTP extends StatefulWidget {
  final dynamic number;

  const CheckInOTP({super.key,required this.number});

  @override
  State<CheckInOTP> createState() => _CheckInOTPState();
}

class _CheckInOTPState extends State<CheckInOTP> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  int _currentIndex = 0;

  void _input(String text) {
    if (_currentIndex < 6) {
      setState(() {
        _controllers[_currentIndex].text = text;
        if (_currentIndex < 5) {
          _currentIndex++;
        }
      });
    }
  }

  void _backspace() {
    setState(() {
      if (_currentIndex > 0) {
        if (_controllers[_currentIndex].text.isEmpty) {
          _currentIndex--;
        }
        _controllers[_currentIndex].clear();
      } else if (_currentIndex == 0) {
        _controllers[_currentIndex].clear();
      }
    });
  }

  String _done() {
    String otp = _controllers.map((e) => e.text).join();
    return otp;
    // Handle the done action, such as submitting the OTP or navigating
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
            ),
            // Add the HeaderWidget here
            HeaderWidget(
              message: 'Check-In', // Set the message to 'Check-In'
              screenWidth: screenWidth,
            ),

            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(
                'Please enter OTP sent to: ${widget.number}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.045,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _BorderButton(double screenWidth, double screenHeight) {
    Widget _buildOTPField(int index) {
      return Container(
        width: screenWidth * 0.1,
        height: screenHeight * 0.06,
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ),
        child: Center(
          child: TextField(
            controller: _controllers[index],
            keyboardType: TextInputType.none, // Disable native keyboard
            textAlign: TextAlign.center,
            maxLength: 1,
            readOnly: true, // Make the field read-only
            style: TextStyle(fontSize: screenWidth * 0.05),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) => _buildOTPField(index)),
        ),
        SizedBox(height: screenHeight * 0.02), // Space between OTP and buttons
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
                border: Border.all(
                    color: const Color.fromRGBO(0, 176, 147, 1), width: 2),
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
              onTap: () async{
                final Map<String, dynamic> data = {
                  'phoneNumber': widget.number as String,
                  'otp': Provider.of<TokenProvider>(context,listen: false).otp //_done()
                };
                final response=await EndpointCaller.postCallEndpoint(endpoint:  "otp/verify",data:data);
                Provider.of<TokenProvider>(context,listen: false).setalreadyExist(response["data"]["is_Verified"]);
                print(response);
                Provider.of<TokenProvider>(context,listen: false).setaccessToken(response["data"]["accessToken"]);
                Provider.of<TokenProvider>(context,listen: false).setrefreshToken(response["data"]["refreshToken"]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPhoto()), // Replace with your actual route
                );
              },
              child: Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.4,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 176, 147, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Row(
                      children: [
                        Text(
                          'Proceed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.15),
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

  Widget _buildButton(String text, double containerWidth,
      {VoidCallback? onPressed}) {
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