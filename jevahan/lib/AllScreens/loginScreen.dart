import 'package:google_fonts/google_fonts.dart';
import 'package:jevahan/AllScreens/mainScreen.dart';
import 'package:jevahan/AllScreens/registrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jevahan/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jevahan/utilities/forgotPasswoordPage.dart';
import 'package:jevahan/utilities/progressDialog.dart';
import 'package:flutter/material.dart'; // ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCFD2CF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(40.0),
              ),
              const SizedBox(
                height: 26.0,
              ),
              Text(
                "Sarathee",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF062833),
                    letterSpacing: 3,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 47,
              ),
              Image(
                image: AssetImage('images/applogo.png'),
                height: 72,
                width: 78,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
              ),
              const SizedBox(
                height: 1.0,
              ),
              // Text(
              //   "Login",
              //   style: GoogleFonts.poppins(
              //     textStyle: TextStyle(
              //         fontSize: 25.0,
              //         fontWeight: FontWeight.w700,
              //         color: Color(0xFF062833)),
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xFF062833),
                            width: 8,
                          ),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontFamily: "Brand Bold",
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    // ignore: prefer_const_constructors
                    GestureDetector(
                      child: TextField(
                        controller: passwordTextEditingController,
                        obscureText: _obsecureText,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                            child: Icon(_obsecureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          filled: true,
                          fillColor: Color(0xFFD9D9D9),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xFF062833))),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontFamily: "Brand Bold",
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                    ),
                    const SizedBox(
                      height: 0.0,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF062833),
                        shape: const StadiumBorder(),
                      ),
                      child: Container(
                        height: 50.0,
                        width: 300.0,
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFFFFFF),
                                  textBaseline: TextBaseline.ideographic),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage(
                              "Email address not valid", context);
                        } else if (passwordTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "Password is mandatory.", context);
                        } else {
                          loginAndAutheticateUser(context);
                        }
                      },
                    )
                  ],
                ),
              ),
              GestureDetector(
                child: Text(
                  'Forgot Password',
                  style: GoogleFonts.cabin(
                    textStyle: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF062833),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, ForgotPasswordPage.idScreen, (route) => false);
                },
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Don't have an Account?",
                style: GoogleFonts.cabin(
                  textStyle:
                      TextStyle(fontSize: 18.0, color: Color(0xFF062833)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF062833),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegistrationScreen.idScreen, (route) => false);
                },
                child: Container(
                  height: 33.0,
                  width: 92,
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      )
                          // style: TextStyle(
                          //     fontSize: 14.0,
                          //     fontFamily: "Brand Bold",
                          //     color: Colors.white),
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAutheticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Authenticating,\n Please Wait.... ",
          );
        });

    final firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    )
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error:$errMsg", context);
    }))
        .user;

    if (firebaseUser != null) {
      userRef.child(firebaseUser.uid).once().then((dataSnapshot) {
        // ignore: unnecessary_null_comparison
        if (dataSnapshot != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          displayToastMessage(
              "You have been Succesfully \nLogged In.", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(
              "No, Records Exist for this User \n Please Register", context);
        }
      });
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      displayToastMessage("Error Occured - Cannot be signed  in ", context);
    }
  }
}
