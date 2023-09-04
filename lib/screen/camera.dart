import 'package:firstapp/screen/result.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:firstapp/screen/start.dart';
import 'package:image/image.dart' as img;

class Camera extends StatefulWidget {
  final int currentTab;
  final Function(int) onTabChanged;

  const Camera(
      {required this.currentTab, required this.onTabChanged, super.key});

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

  Future<String> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // print("Image picked from gallery: ${pickedFile.path}");
      return pickedFile.path;
    }
    return "";
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(
        cameras[direction], ResolutionPreset.high,
        enableAudio: false);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {});
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void toggleFlash() {
    setState(() {
      if (flashMode == FlashMode.off) {
        flashMode = FlashMode.torch;
      } else {
        flashMode = FlashMode.off;
      }
      cameraController.setFlashMode(flashMode);
    });
  }

  Future<String> uploadImageToFirebase(File imageFile, String imageName) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef = storage.ref();
      Reference imageRef = storageRef.child('images/$imageName');
      UploadTask uploadTask = imageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      // print("Image uploaded. URL: $imageUrl");
      return imageUrl;
    } catch (e) {
      // print("Error uploading image: $e");
      return "";
    }
  }

  Future<void> saveUserImageToFirestore(String imageUrl, String email) async {
    final firestoreInstance = FirebaseFirestore.instance;

    // Reference the "images" collection and create a new document with the user's UID
    final imageDocRef = firestoreInstance.collection("images");

    final imageData = {
      "imageUrl": imageUrl,
      "user": email,
    };

    await imageDocRef.add(imageData);
  }

  Future<File> cropImage(File imageFile) async {
    try {
      img.Image image = img.decodeImage(await imageFile.readAsBytes())!;
      int size = image.width < image.height ? image.width : image.height;
      int x = (image.width - size + 90) ~/ 2;
      int y = (image.height - size) ~/ 2;

      img.Image croppedImage = img.copyCrop(
        image,
        x: x,
        y: y,
        width: size - 90,
        height: size - 90,
      );

      File croppedFile =
          File(imageFile.path.replaceAll('.jpg', '_cropped.jpg'));
      croppedFile.writeAsBytesSync(img.encodeJpg(croppedImage));

      return croppedFile;
    } catch (e) {
      return imageFile; // Return the original image on error
    }
  }

  @override
  Widget build(BuildContext context) {
    final userCredential =
        Provider.of<UserCredentialProvider>(context).userCredential;
    final email = userCredential?.user?.email;
    // ignore: unused_local_variable
    String imageUrlP = "";
    try {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF5F93A0),
          title: const Text(
            'Scanner',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ],
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          children: [
            CameraPreview(cameraController),
            Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset(
                  'assets/scanner.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: 20.0, // Adjust this value as needed
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
              child:
                  button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () async {
                  String? imagePath =
                      await pickImageFromGallery(); // Note the use of String? for imagePath

                  if (imagePath.isEmpty) {
                    // User canceled image picking, do nothing
                    return;
                  }

                  File imageFile = File(imagePath);
                  uploadImageToFirebase(imageFile, imagePath).then((imageUrl) {
                    if (imageUrl != "") {
                      imageUrlP = imagePath;
                      saveUserImageToFirestore(imageUrl, email!);
                    } else {
                      // Handle the case where image upload failed
                    }
                  });

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Result(inputString: imagePath),
                    ),
                  );
                },
                child: button(Icons.photo_library, Alignment.bottomRight),
              ),
            )
          ],
        ),
        bottomNavigationBar: buildBottomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF5F9EA0),
          child: const Icon(Icons.camera_alt_rounded, color: Colors.black),
          onPressed: () {
            cameraController.takePicture().then((XFile? file) async {
              if (mounted) {
                if (file != null) {
                  // print("Picture saved to ${file.path}");
                  File imageFile = File(file.path);
                  File croppedImageFile = await cropImage(imageFile);
                  uploadImageToFirebase(croppedImageFile, croppedImageFile.path)
                      .then((imageUrl) {
                    if (imageUrl != "") {
                      // print("Image uploaded to Firebase Storage. URL: $imageUrl");
                      imageUrlP = croppedImageFile.path;
                      // print("Image path. URL: $imageUrlP");
                      saveUserImageToFirestore(imageUrl, email!);
                    } else {}
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Result(inputString: croppedImageFile.path),
                    ),
                  );
                }
              }
            });
          },
        ),
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  BottomAppBar buildBottomNavBar() {
    return BottomAppBar(
      color: const Color(0xFF008080),
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNavBarItem(Icons.home, 0),
                buildNavBarItem(Icons.history, 1),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNavBarItem(Icons.newspaper, 2),
                buildNavBarItem(Icons.person, 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    bool isSelected = widget.currentTab == index;
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        widget.onTabChanged(index);
        Navigator.pop(context);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? const Color(0xFF5F9EA0) : Colors.transparent,
        ),
        child: Icon(
          icon,
          // color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
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
                offset: Offset(2, 2),
                blurRadius: 10,
              )
            ]),
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
