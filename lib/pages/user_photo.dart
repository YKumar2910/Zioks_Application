// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:zioks_application/routes.dart';

class UserPhoto extends StatefulWidget {
  @override
  _UserPhotoState createState() => _UserPhotoState();
}

class _UserPhotoState extends State<UserPhoto> {
  File? _image;
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
              SizedBox(height: screenHeight * 0.05),

              Text(
                'User Photo',
                style: TextStyle(
                  fontSize: screenWidth * 0.1,
                  color: Colors.teal.shade400,
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              _image == null
                  ? Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: Image(
                  image: AssetImage('assets/images/personimage.jpeg'),
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.5,
                ),
              )
                  : Image.file(
                _image!,
                height: screenHeight * 0.3,
                width: screenWidth * 0.5,
                fit: BoxFit.cover,
              ),

              SizedBox(height: screenHeight * 0.05),

              SizedBox(
                width: screenWidth * 0.6,
                height: screenHeight * 0.08,
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
                    style: TextStyle(fontSize: screenWidth * 0.05,color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.08,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Retake', style: TextStyle(fontSize: screenWidth * 0.04,color: Colors.white)),
                          SizedBox(width: 7),
                          Icon(Icons.refresh, size: screenWidth * 0.04),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.teal.shade400,
                      ),
                      onPressed: () => Navigator.pushNamed(context, MyRoutes.purposepageRoute),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Next', style: TextStyle(fontSize: screenWidth * 0.04,color: Colors.white)),
                          SizedBox(width: 17),
                          Icon(Icons.arrow_forward, size: screenWidth * 0.04),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
