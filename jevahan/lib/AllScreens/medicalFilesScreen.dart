import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jevahan/AllScreens/mainScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jevahan/AllScreens/registrationScreen.dart';

class medicalFilesScreen extends StatefulWidget {
  static const String idScreen = "medicalfiles";

  const medicalFilesScreen({super.key});

  @override
  State<medicalFilesScreen> createState() => _medicalFilesScreenState();
}

class _medicalFilesScreenState extends State<medicalFilesScreen> {
  File? sampleImage;

  Future getImage() async {
    var tempImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      sampleImage = tempImage as File;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF062833),
        // title: Icon(
        //   Icons.arrow_back,
        //   color: Colors.white,
        // ),
        title: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () => {
            Navigator.pushNamedAndRemoveUntil(
                context, MainScreen.idScreen, (route) => false),
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              Center(
                child: (sampleImage == null) ? Text('') : enableUpload(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Travel Documents",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 30)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  height: 65,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(0xFF8D689E),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 14, 0, 10),
                      child: Row(
                        children: [
                          Text(
                            "Click here to Upload",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  getImage();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 1, 16, 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.upload_file,
                        size: 50,
                      ),
                      onTap: () {
                        // uploadFile;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
        child: Column(
      children: <Widget>[
        Image.file(
          (sampleImage!),
          height: 300.0,
          width: 300.0,
        ),
        ElevatedButton(
            onPressed: () async {
              final Reference firebaseStorageRef =
                  FirebaseStorage.instance.ref().child('myimage.jpg');

              final UploadTask task = firebaseStorageRef.putFile(sampleImage!);
            },
            child: Text('Upload'))
      ],
    ));
  }
}


// Firebase changes: request.time < timestamp.date(2022, 12, 18);