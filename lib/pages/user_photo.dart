// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserPhoto extends StatefulWidget {
  @override
  _UserPhotoState createState() => _UserPhotoState();
}

class _UserPhotoState extends State<UserPhoto> {
  File? _image; //Stores the image
  final ImagePicker _picker = ImagePicker();

  Future<void> _takePhoto() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05), // 5% of the screen height
              
              // "User Photo" Text
              Text(
                'User Photo',
                style: TextStyle(
                  fontSize: screenWidth * 0.1, // Font size is 10% of the screen width
                  color: Colors.teal.shade500,
                ),
              ),
              
              SizedBox(height: screenHeight * 0.05), // 5% of screen height

              // Display placeholder or captured image
              _image == null
                  ? Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                      child: Image(
                        image: AssetImage('assets/freepik-export-20240822133548eLgG.jpeg'),
                        height: screenHeight * 0.3, // 30% of screen height
                        width: screenWidth * 0.5, // 50% of screen width
                      ),
                    )
                  : Image.file(
                      _image!,
                      height: screenHeight * 0.3, // 30% of screen height
                      width: screenWidth * 0.5, // 50% of screen width
                      fit: BoxFit.cover,
                    ),
              
              SizedBox(height: screenHeight * 0.05), // 5% of screen height

              // Take Photo button
              SizedBox(
                width: screenWidth * 0.6, // Button width is 60% of screen width
                height: screenHeight * 0.08, // Button height is 8% of screen height
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.teal.shade400,
                  ),
                  onPressed: _takePhoto,
                  child: Text(
                    'Take Photo',
                    style: TextStyle(fontSize: screenWidth * 0.05), // Font size is 5% of screen width
                  ),
                ),
              ),
              
              SizedBox(height: screenHeight * 0.05), // 5% of screen height

              // Row with Retake and Next buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Retake button
                  SizedBox(
                    width: screenWidth * 0.3, // Button width is 30% of screen width
                    height: screenHeight * 0.08, // Button height is 8% of screen height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.teal.shade400,
                      ),
                      onPressed: () async {
                        setState(() {
                          _image = null;
                        });

                        final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
                        if (pickedFile != null) {
                          setState(() {
                            _image = File(pickedFile.path);
                          });
                        }
                      },
                      child: Text(
                        'Retake',
                        style: TextStyle(fontSize: screenWidth * 0.05), // Font size is 5% of screen width
                      ),
                    ),
                  ),

                  // Next button
                  SizedBox(
                    width: screenWidth * 0.3, // Button width is 30% of screen width
                    height: screenHeight * 0.08, // Button height is 8% of screen height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.teal.shade400,
                      ),
                      onPressed: () {
                        // Handle Next button press
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Next'),
                              content: Text('Next button pressed.'),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Next',
                        style: TextStyle(fontSize: screenWidth * 0.05), // Font size is 5% of screen width
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: screenHeight * 0.05), // 5% of screen height
            ],
          ),
        ),
      ),
    );
  }
}
