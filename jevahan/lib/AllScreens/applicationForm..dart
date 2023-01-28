import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jevahan/AllScreens/community.dart';
import 'package:jevahan/AllScreens/mainScreen.dart';

class ApplicationForm extends StatefulWidget {
  static const String idScreen = "applicationForm";

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController patientDesTextEditingController =
      TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF062833),
        shadowColor: Colors.black,
        foregroundColor: Colors.white,
        title: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, MainScreen.idScreen, (route) => false);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 13,
                  ),
                  Text(
                    "Your Valuable Feedback Matters",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Image(
                image: AssetImage('images/applogo.png'),
                height: 72,
                width: 78,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35.0, 35, 35, 15),
                child: TextFormField(
                  // controller: emailTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 234, 231, 231),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF062833),
                        width: 8,
                      ),
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      fontFamily: "Brand Bold",
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 15),
                child: TextField(
                  // controller: emailTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 234, 231, 231),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF062833),
                        width: 8,
                      ),
                    ),
                    labelText: "Gender",
                    labelStyle: TextStyle(
                      fontFamily: "Brand Bold",
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 15),
                child: TextField(
                  // controller: emailTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 234, 231, 231),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF062833),
                        width: 8,
                      ),
                    ),
                    labelText: "How was the overall performance of the app?",
                    labelStyle: TextStyle(
                      fontFamily: "Brand Bold",
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 15),
                child: TextField(
                  // controller: emailTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 234, 231, 231),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF062833),
                        width: 8,
                      ),
                    ),
                    labelText: "How is the weather?",
                    labelStyle: TextStyle(
                      fontFamily: "Brand Bold",
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF062833),
                  shape: const StadiumBorder(),
                ),
                child: Container(
                  height: 50.0,
                  width: 300.0,
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                          color: Color(0xFFFFFFFF)),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
