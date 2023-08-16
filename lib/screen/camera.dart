import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;
  FlashMode flashMode = FlashMode.off;

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }
  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("Image picked from gallery: ${pickedFile.path}");
      // Use the pickedFile for your purpose (e.g., upload or display it)
    }
  }
  void startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[direction], ResolutionPreset.high, enableAudio: false);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void toggleFlash() {
    setState(() {
      if (flashMode == FlashMode.off) {
        flashMode = FlashMode.torch; // Changed from FlashMode.on to FlashMode.torch
      } else {
        flashMode = FlashMode.off;
      }
      cameraController.setFlashMode(flashMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5F93A0),
          title: Text(
            'Scanner',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            CameraPreview(cameraController),
            Center(
              child: Container(
                width: 300,
                height: 300,
                child: Image.asset(
                  'assets/scanner.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 20.0,  // Adjust this value as needed
              left: 0,
              right: 0,
              child: Center(
                child: flashButton(),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  startCamera(direction);
                });
              },
              child: button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {
                cameraController.takePicture().then((XFile? file) {
                  if (mounted) {
                    if (file != null) {
                      print("Picture saved to ${file.path}");
                    }
                  }
                });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
            GestureDetector(
              onTap: () {
                pickImageFromGallery();
              },
              child: button(Icons.photo_library, Alignment.bottomRight),
            ),
          ],
        ),
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  Widget flashButton() {
    return GestureDetector(
      onTap: toggleFlash,
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2,2),
                blurRadius: 10,
              )
            ]
        ),
        child: Center(
          child: Icon(
            flashMode == FlashMode.torch ? Icons.flash_on : Icons.flash_off,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

