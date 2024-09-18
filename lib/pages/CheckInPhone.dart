import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zioks_application/pages/checkInScanQR.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              _CheckIn(),
              _ToggleButton(),
              _MobileNumber(),
              _KeyPad(),
            ],
          ),
      ),
    );
  }

  Widget _CheckIn() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Check-In',
          style: TextStyle(
            color: Color.fromRGBO(0, 176, 147, 1),
            fontSize: 30,
          ),)
        ],
      ),
    );
  }

  Widget _ToggleButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the box horizontally in the row
        children: [
          Container(
            width: 300, // [Adjust the width of the box as needed]
            height: 50, // [Adjust the height of the box as needed]
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // [Set the border radius for rounded corners]
              border: Border.all(color: Colors.black, width: 1), // [Set the border color and thickness]
            ),
            child: Row(
              children: [
                // [First half: Mobile Number]
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 176, 147, 1), // [Set background color of the first half to teal]
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10), // [Rounded corners for top-left]
                        bottomLeft: Radius.circular(10), // [Rounded corners for bottom-left]
                      ),
                    ),
                    alignment: Alignment.center, // [Center the text vertically and horizontally]
                    child: Text(
                      'Mobile Number',
                      style: TextStyle(
                        color: Colors.white, // [Text color set to white]
                        fontSize: 16, // [Set font size for the text]
                      ),
                    ),
                  ),
                ),

                // [Second half: Have QR]
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckInScanQR()), // Navigate to the ScanQR page
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // [Set background color of the second half to white]
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10), // [Rounded corners for top-right]
                          bottomRight: Radius.circular(10), // [Rounded corners for bottom-right]
                        ),
                      ),
                      alignment: Alignment.center, // [Center the text vertically and horizontally]
                      child: Text(
                        'Have QR',
                        style: TextStyle(
                          color: Colors.black, // [Text color set to black]
                          fontSize: 16, // [Set font size for the text]
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _MobileNumber() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 25.0, right: 25.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey, // Bottom border color
              width: 1.5, // Thickness of the bottom border
            ),
          ),
        ),
        child: Row(
          children: [
            // Country Flag
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/images/world_16397066.png', // Path to your flag image
                width: 30,
                height: 20,
              ),
            ),

            // Country Code
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                '+91', // Country code, can be dynamic
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),

            // Mobile Number Input
            Expanded(
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter Mobile Number',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Bottom border color
                  ),// No border for input
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _KeyPad() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center the keypad vertically
        crossAxisAlignment: CrossAxisAlignment.stretch, // Center the keypad horizontally
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(''),
              _buildButton('0'),
              _buildButton('⌫', onPressed: _backspace),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {VoidCallback? onPressed}) {
    return Container(
      margin: EdgeInsets.all(8.0), // Margin between buttons for spacing
      child: ElevatedButton(
        onPressed: onPressed ?? () => _input(text),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(), // Circular shape
          padding: EdgeInsets.all(16), // Adjust button size
          side: BorderSide(color: Colors.black, width: 2),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15, // Adjust font size if needed
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _input(String text) {
    // Handle input text
  }

  void _backspace() {
    // Handle backspace
  }

}
