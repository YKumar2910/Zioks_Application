// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:zioks_application/endpoint_caller.dart';
import 'package:zioks_application/routes.dart';
import 'package:zioks_application/widgets/custom_widget.dart';

class UserPhoto extends StatefulWidget {
  @override
  _UserPhotoState createState() => _UserPhotoState();
}

class _UserPhotoState extends State<UserPhoto> {
  File? _image;
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  late List<CameraDescription> cameras;
  CameraDescription? selectedCamera;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        selectedCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

        _controller = CameraController(
          selectedCamera!,
          ResolutionPreset.high,
        );
        _initializeControllerFuture = _controller!.initialize();
        setState(() {}); // Refresh the UI after initialization
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _takePhoto() async {
    try {
      await _initializeControllerFuture;

      final XFile imageFile = await _controller!.takePicture();
      setState(() {
        _image = File(imageFile.path);
      });
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  void _switchCamera() {
    if (cameras.isNotEmpty) {
      setState(() {
        selectedCamera = (selectedCamera!.lensDirection == CameraLensDirection.front)
            ? cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back)
            : cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);


        _controller = CameraController(
          selectedCamera!,
          ResolutionPreset.high,
        );
        _initializeControllerFuture = _controller!.initialize();
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
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

              HeaderWidget(message: 'User Photo', screenWidth: screenWidth),

              SizedBox(height: screenHeight * 0.05),

              _image == null
                  ? FutureBuilder<void>(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (_controller != null) {
                            return Container(
                              height: screenHeight * 0.3,
                              width: screenWidth * 0.5,
                              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                              child: CameraPreview(_controller!),
                            );
                          } else {
                            return Center(
                              child: Text('No camera found'),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error initializing camera'),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
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
                    backgroundColor: Color.fromRGBO(0, 176, 147, 1),
                  ),
                  onPressed: (){if(_image==null){_takePhoto();}},
                  child: Text(
                    'Take Photo',
                    style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white),
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
                        backgroundColor: Color.fromRGBO(0, 176, 147, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Retake', style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white)),
                          SizedBox(width: 7),
                          Icon(Icons.refresh, size: screenWidth * 0.04, color: Colors.white),
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
                        backgroundColor: Color.fromRGBO(0, 176, 147, 1),
                      ),
                      onPressed: () {
                        
                        var response= EndpointCaller.postCallEndpoint('upload-image', );
                        Navigator.pushNamed(context, MyRoutes.purposepageRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Next', style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white)),
                          SizedBox(width: 17),
                          Icon(Icons.arrow_forward, size: screenWidth * 0.04, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.05),

              SizedBox(
                width: screenWidth * 0.4,
                height: screenHeight * 0.08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Color.fromRGBO(0, 176, 147, 1),
                  ),
                  onPressed: _switchCamera,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Switch Camera', style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white)),
                      SizedBox(width: 10),
                      Icon(Icons.switch_camera, size: screenWidth * 0.04, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
