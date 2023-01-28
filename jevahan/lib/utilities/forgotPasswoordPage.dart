import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jevahan/AllScreens/loginScreen.dart';
import 'package:jevahan/AllScreens/registrationScreen.dart';
// import 'package:firebase_auth_forgot_password/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String idScreen = "forgotpswd";

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCFD2CF),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(40.0),
              ),
              const SizedBox(
                height: 26.0,
              ),
              Text(
                "JeVahan",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF062833)),
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
              SizedBox(
                height: 30,
              ),
              Text(
                "Reset Password",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF062833)),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
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
                      labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    resetPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF062833),
                    shape: const StadiumBorder(),
                  ),
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.white,
                  ),
                  label: Container(
                    height: 50.0,
                    width: 300.0,
                    padding: const EdgeInsets.all(13.0),
                    child: Center(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Brand Bold",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());

    displayToastMessage('Password Reset Email Sent', context);

    Navigator.of(context).popUntil((Route) => Route.isFirst);
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.idScreen, (route) => false);
  }
}
