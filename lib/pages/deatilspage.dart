// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:zioks_application/routes.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen height and width
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Set form width and height based on the screen size
    double formWidth = screenWidth < 600 ? screenWidth * 0.9 : 500;
    double formHeight = screenHeight * 0.8;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: formWidth,   // Set width for responsiveness
            height: formHeight, // Set height for responsiveness
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: screenHeight*0.03,),
                  Text(
                    'Please fill the following information',
                    style: TextStyle(
                      fontSize: screenWidth*0.02397,
                      
                      color: Color.fromRGBO(0, 176, 147, 1)
                    ),
                  ),
                  SizedBox(height: screenHeight*0.05),
                  _buildTextFormField(
                    label: 'First Name',
                    controller: _firstNameController,
                    validatorMessage: 'Please enter your first name',
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    label: 'Last Name',
                    controller: _lastNameController,
                    validatorMessage: 'Please enter your last name',
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    label: 'Email ID',
                    controller: _emailController,
                    validatorMessage: 'Please enter your email ID',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email ID';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  _buildTextFormField(
                    label: 'Address',
                    controller: _addressController,
                    validatorMessage: 'Please enter your address',
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Mobile Number',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8), 
                      Row(
                         crossAxisAlignment: CrossAxisAlignment.start, // Aligns both fields to the top
                         children: [
                          Container(
                          width: 80,
                          height: 150, // Adjust width as necessary for the dropdown
                            child: DropdownButtonFormField<String>(
                              value: '+91',
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                              ),
                              icon: Icon(Icons.arrow_drop_down),
                              items: ['+91', '+1', '+44'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(width: 10), // Space between dropdown and TextFormField
                          Expanded(
                            child: TextFormField(
                              controller: _mobileNumberController,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed:() => Navigator.pushNamed(context, MyRoutes.purposepageRoute),
                      child: Text('Next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build each TextFormField
  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    required String validatorMessage,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(color: Colors.black, fontSize: 22),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold ),
          decoration: InputDecoration(
            hintText: label,
            border: UnderlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            floatingLabelBehavior: FloatingLabelBehavior.never, // Keeps the label fixed
          ),
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return validatorMessage;
                }
                return null;
              },
        ),
      ],
    );
  }
}
