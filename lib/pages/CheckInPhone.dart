// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zioks_application/endpoint_caller.dart';
import 'package:zioks_application/pages/checkInScanQR.dart';
import 'package:zioks_application/pages/checkInOTP.dart';
import 'package:zioks_application/token_provider.dart';
import 'package:zioks_application/widgets/custom_widget.dart';
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
    // Get screen width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.1),  // Adjust the height using screenHeight
          HeaderWidget(
            message: 'Check In',  // Use "Check In" as the message
            screenWidth: screenWidth,  // Pass screenWidth to the HeaderWidget
          ),
        ],
      ),
    );
  }


  // check in via mobile number or qr code
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
                    color: const Color.fromRGBO(0, 176, 147, 1),
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
                      MaterialPageRoute(builder: (context) => CheckInScanQR(text: "Check-In")),
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

  // phone number as input followed by the next button
  Widget _NextButton(double buttonWidth, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () async{
              if (_controller.text.length == 10) {
                final Map<String, dynamic> data = {
                  'phoneNumber': "+91${_controller.text}",
                };
                var response=await EndpointCaller.postCallEndpoint(endpoint:  'otp/generate',data:  data);
                Provider.of<TokenProvider>(context,listen: false).setOTP(response["data"]["otp"]);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckInOTP(number: '+91${_controller.text}')),
                );
              } else {
                _done(); // Trigger validation if Next is pressed without a valid number
              }
            },
            child: Container(
              width: buttonWidth,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 176, 147, 1),
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

  // shows the keypad for entering the mobile number
  Widget _MobileNumber(double containerWidth) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            SizedBox(
              width: screenWidth * 0.2,
              child: CountryCodePicker(
                mode: CountryCodePickerMode.dialog,
                onChanged: (country) {
                  print('Country code selected: ${country.code}');
                },
                initialSelection: '+91',
                showFlag: true,
                showDropDownButton: true,
              ),
            ),
            SizedBox(width: screenWidth*0.0001),
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

  // design of the keypad
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

