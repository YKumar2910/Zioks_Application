// ignore_for_file: prefer_const_constructors

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double formWidth = screenWidth < 600 ? screenWidth * 0.9 : 500;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: formWidth,
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Please fill the following information',
                      style: TextStyle(
                        fontSize: screenWidth * 0.02397,
                        color: Color.fromRGBO(0, 176, 147, 1),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
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
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {});
                                },
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: _mobileNumberController,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                                // validatorMessage: 'Please enter your email ID', 
                                validator: (value) 
                                {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Phone number';
                                  }
                                  if (!(value.length == 10)) {
                                    return 'Please enter a valid Phone Number';
                                  }
                                  return null;
                                } ,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Center(
                      child: ElevatedButton(
                        onPressed: () =>
                          { 
                              if (_formKey.currentState!.validate())
                            {
                              Navigator.pushNamed(
                                  context, MyRoutes.companySearchRoute),
                            },
                          },
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
      ),
    );
  }

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
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: label,
            border: UnderlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            floatingLabelBehavior: FloatingLabelBehavior.never,
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
