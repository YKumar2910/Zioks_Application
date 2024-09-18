import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Row();
  }

  Widget _MobileNumber() {
    return Row();
  }

  Widget _KeyPad() {
    return Row();
  }
}
