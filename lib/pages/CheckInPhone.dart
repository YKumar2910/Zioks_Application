import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zioks_application/pages/checkInScanQR.dart';
import 'package:zioks_application/pages/checkInOTP.dart';
import 'package:http/http.dart' as http;

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final TextEditingController _controller = TextEditingController(); // Controller for the TextField
  String? _errorMessage; // Validation message

  void _input(String text) {
    setState(() {
      _controller.text += text; // Append the tapped number to the TextField
      _errorMessage = null;  // Clear validation message
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
    if (_controller.text.length != 10) { // Validate phone number
      setState(() {
        _errorMessage = "Please enter a valid 10-digit mobile number"; // Set validation message
      });
      return;
    }
    print("Done with number: ${_controller.text}");
    // Handle the done action, such as submitting the phone number or navigating
  }

  @override
  Widget build(BuildContext context) {
    // Getting screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _CheckIn(screenHeight * 0.05), // Adjusted for screen height
            _ToggleButton(screenWidth * 0.8), // Adjusted for screen width
            _MobileNumber(screenWidth * 0.9), // Adjusted for screen width
            if (_errorMessage != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red), // Error message in red color
                ),
              ),
            ],
            _NextButton(screenWidth * 0.4, context), // Adjusted for screen width
            _KeyPad(screenWidth * 0.6, screenHeight * 0.6), // Adjusted for screen width
          ],
        ),
      ),
    );
  }

  Widget _CheckIn(double topPadding) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Check-In',
            style: TextStyle(
              color: Color.fromRGBO(0, 176, 147, 1),
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ToggleButton(double containerWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Container(
          width: containerWidth,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 176, 147, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Mobile Number',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckInScanQR()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Have QR',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Map<String,dynamic>> callEndpoint() async{
    final Map<String, dynamic> data = {
      'phone_number': "+91${_controller.text}",
    };
    try {
      final res=await http.post(Uri.parse(
        'https://lab.stagingit.net/vms/api/visitors/otp/generate'
        ),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(data)
      );
      final resDecode=jsonDecode(res.body);
      if(resDecode["statusCode"]!=200){
          throw resDecode['message'];
      }
      print(resDecode);
      return resDecode; 
      } on Exception catch (e) {
        throw e.toString();
    }
  }
  Widget _NextButton(double buttonWidth, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async{
              if (_controller.text.length == 10) {
                var response=await callEndpoint();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckInOTP(number: '+91${_controller.text}',otp:  response['data']['otp'])),
                );
              } else {
                _done(); // Trigger validation if Next is pressed without a valid number
              }
            },
            child: Container(
              width: buttonWidth,
              height: 50,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 176, 147, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 45),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _MobileNumber(double containerWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        width: containerWidth,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/images/world_16397066.png',
                width: 30,
                height: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                '+91',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _KeyPad(double containerWidth, double containerHeight) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
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
        padding: const EdgeInsets.only(top: 20),
        child: Container(
            width: buttonSize,
            height: buttonSize, // Ensure the container is square
            margin: EdgeInsets.all(4.0),
            child: ElevatedButton(
            onPressed: onPressed ?? () => _input(text),
    style: ElevatedButton.styleFrom(
    shape: CircleBorder(),
    padding: EdgeInsets.all(buttonSize * 0.3), // Padding relative to button size
    side: BorderSide(color: Colors.black, width: 1),
    ),
    child: FittedBox( // Ensures text scales well with the button size
    fit: BoxFit.scaleDown,
    child: Text(
    text,
      style: TextStyle(
        fontSize: 24, // Text size
        color: Colors.black,
      ),
    ),
    ),
            ),
        ),
    );
  }
}

