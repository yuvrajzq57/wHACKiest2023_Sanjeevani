import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jevahan/AllScreens/loginScreen.dart';

class GetStartedScreen extends StatelessWidget {
  static const String idScreen = "getStartedScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCFD2CF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(28.0),
                ),
                const SizedBox(
                  height: 80.0,
                ),
                Text(
                  "Sarathee",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF062833),
                        letterSpacing: 3),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 63,
                ),
                Image(
                  image: AssetImage('images/applogo.png'),
                  height: 72,
                  width: 78,
                ),
                SizedBox(
                  height: 76,
                ),
                Text(
                  "A SLOGAN FOR PROJECT",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0D3C4B)),
                  ),
                ),
                SizedBox(
                  height: 225,
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
                    height: 49.0,
                    width: 272,
                    padding: const EdgeInsets.all(13.0),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Brand Bold",
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
