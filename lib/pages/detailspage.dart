import 'package:flutter/material.dart';
import 'package:zioks_application/routes.dart';
import 'package:zioks_application/widgets/custom_widget.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';

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

    double formWidth = screenWidth * 0.8 ;

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
                    // SizedBox(height: screenHeight * 0.02),
                    Center(
                    child: HeaderWidget(
                      message: "Please fill the following information",
                      screenWidth: screenWidth,
                      fontSize: screenWidth*0.04,
                    )
                  ),
                    SizedBox(height: screenHeight * 0.08),
                    _buildTextFormField(
                      label: 'First Name',
                      controller: _firstNameController,
                      validatorMessage: 'Please enter your first name',
                    ),
                    SizedBox(height: screenHeight*0.025),
                    _buildTextFormField(
                      label: 'Last Name',
                      controller: _lastNameController,
                      validatorMessage: 'Please enter your last name',
                    ),
                    SizedBox(height: screenHeight*0.025),
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
                    SizedBox(height: screenHeight*0.025),
                    _buildTextFormField(
                      label: 'Address',
                      controller: _addressController,
                      validatorMessage: 'Please enter your address',
                    ),
                    SizedBox(height: screenHeight*0.025),
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
                        SizedBox(height: screenHeight*0.015),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: formWidth*0.04,
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
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                controller: _mobileNumberController,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                ),
                                validator: (value) 
                                {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Phone number';
                                  }
                                  if (!(value.length==10)) {
                                    return 'Please enter a valid Phone number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight*0.06),
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
                        child: Text('Next', style: TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 176, 147, 1),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 16,
                          ),
                          textStyle: TextStyle(
                            fontSize: 25,
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
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(fontSize: 20, color: Colors.grey.shade700, fontWeight: FontWeight.normal),
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
