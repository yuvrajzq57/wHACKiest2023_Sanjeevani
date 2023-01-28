import 'package:flutter/material.dart';
import 'package:jevahan/AllScreens/applicationForm..dart';
import 'package:jevahan/AllScreens/bookedAmbulanceScreenICU.dart';
import 'package:jevahan/AllScreens/contactScreen.dart';
import 'package:jevahan/AllScreens/guide_details.dart';
import 'package:jevahan/AllScreens/loginScreen.dart';
import 'package:jevahan/AllScreens/mainScreen.dart';
import 'package:jevahan/AllScreens/medicalFilesScreen.dart';
import 'package:jevahan/AllScreens/mobileICUsearchService.dart';
import 'package:jevahan/AllScreens/mobileicuhomescreen.dart';
import 'package:jevahan/AllScreens/optionsMobileICU.dart';
import 'package:jevahan/AllScreens/profile_screen.dart';
import 'package:jevahan/AllScreens/registrationScreen.dart';
import 'package:jevahan/AllScreens/getStartedScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jevahan/AllScreens/searchscreen.dart';
import 'package:jevahan/AllScreens/sideScreen.dart';
import 'package:jevahan/utilities/forgotPasswoordPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AllScreens/splashScreen.dart';
import 'AllScreens/theme_provider.dart';
import 'AllScreens/community.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          // home: CommunityScreen(),
          initialRoute: FirebaseAuth.instance.currentUser == null
              ? Splash.idScreen
              : MainScreen.idScreen,
          routes: {
            Splash.idScreen: (context) => Splash(),
            RegistrationScreen.idScreen: (context) => RegistrationScreen(),
            LoginScreen.idScreen: (context) => LoginScreen(),
            ForgotPasswordPage.idScreen: (context) => ForgotPasswordPage(),
            GetStartedScreen.idScreen: (context) => GetStartedScreen(),
            MainScreen.idScreen: (context) => MainScreen(),
            medicalFilesScreen.idScreen: (context) => medicalFilesScreen(),
            ContactScreen.idScreen: (context) => ContactScreen(),
            SearchScreen.idScreen: (context) => SearchScreen(),
            optionMobileICU.idScreen: (context) => optionMobileICU(),
            homescreenicu.idScreen: (context) => homescreenicu(),
            ApplicationForm.idScreen: (context) => ApplicationForm(),
            MobileIcuService.idScreen: (context) => MobileIcuService(),
            bookedAmbulanceScreenICU.idScreen: (context) =>
                bookedAmbulanceScreenICU(),
            CommunityScreen.idScreen: (context) => CommunityScreen(),
            ProfileScreen.idScreen: (context) => ProfileScreen(),
            GuideScreen.idScreen: (context) => GuideScreen(),
            sideNavigationDrawer.idScreen: (context) => sideNavigationDrawer(),
          },
          debugShowCheckedModeBanner: false,
        );
      });
}
