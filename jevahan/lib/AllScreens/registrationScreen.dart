import 'package:jevahan/AllScreens/loginScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jevahan/AllScreens/mainScreen.dart';
import 'package:jevahan/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jevahan/utilities/progressDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  static const String idScreen = "register";
  late String _name;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController phoneTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();
  bool _obsecureText = true;
  String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCFD2CF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(28.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Sarathee",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF062833),
                      letterSpacing: 2),
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
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      onChanged: (value) => setState(
                        () => _name = value,
                      ),
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
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
                        labelText: "Name",
                        labelStyle: TextStyle(
                          fontFamily: "Brand Bold",
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 4.0,
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
                      height: 4.0,
                    ),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
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
                        labelText: "Phone",
                        labelStyle: TextStyle(
                          fontFamily: "Brand Bold",
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    // ignore: prefer_const_constructors
                    TextField(
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
                        fillColor: const Color(0xFFD9D9D9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Color(0xFF062833),
                            width: 8,
                          ),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontFamily: "Brand Bold",
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                    ),
                    const SizedBox(
                      height: 1.0,
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
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Brand Bold",
                              color: Color(0xFFFFFFFF)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        if (nameTextEditingController.text.length < 5) {
                          displayToastMessage(
                              "Name must be at leat 4 character,", context);
                        } else if (!emailTextEditingController.text
                            .contains("@")) {
                          displayToastMessage(
                              "Email address not valid", context);
                        } else if (phoneTextEditingController.text.isEmpty) {
                          displayToastMessage(
                              "Phone number is mandatory", context);
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          displayToastMessage(
                              "Password should be atleast 5 Characters.",
                              context);
                        } else {
                          registerNewUser(context);
                        }
                        print(_name);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              const Text(
                "Already have an Account?",
                style: TextStyle(
                    fontFamily: "Brand Bold", fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF062833),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
                child: Container(
                  height: 33.0,
                  width: 92,
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "Brand Bold",
                          color: Colors.white),
                      textAlign: TextAlign.center,
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

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Registering New User,\n Please Wait.... ",
          );
        });

    final firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      {
        displayToastMessage("Error$errMsg", context);
      }
    }))
        .user;

    if (firebaseUser != null) {
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      userRef.child(firebaseUser.uid).set(userDataMap);
      // ignore: use_build_context_synchronously
      displayToastMessage(
          "Congratulations,\n Your Account has been created.", context);

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.idScreen, (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      // ignore: use_build_context_synchronously
      displayToastMessage("User hasn't been created", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
