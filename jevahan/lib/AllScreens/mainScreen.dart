import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jevahan/AllScreens/community.dart';
import 'package:jevahan/AllScreens/contactScreen.dart';
import 'package:jevahan/AllScreens/getStartedScreen.dart';
import 'package:jevahan/AllScreens/loginScreen.dart';
import 'package:jevahan/AllScreens/medicalFilesScreen.dart';
import 'package:jevahan/AllScreens/mobileICUsearchService.dart';
import 'package:jevahan/AllScreens/optionsMobileICU.dart';
import 'package:jevahan/AllScreens/splashScreen.dart';
import 'package:jevahan/AllScreens/sideScreen.dart';
import 'package:jevahan/AllScreens/theme_provider.dart';
import 'package:jevahan/utilities/theme_button.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  final String key = "AIzaSyA3QShZcuKPRUuNI4uYH_iceRisE1ENLPM";
  CarouselController buttonCarouselController = CarouselController();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  List<String> images = [
    'images/iconmap.png',
    'images/iconmap.png',
    'images/iconmap.png',
    'images/iconmap.png',
    'images/iconmap.png',
    'images/iconmap.png',
    'images/iconmap.png',
    'images/iconmap.png',
  ];

  final List<Marker> __markers = <Marker>[
    Marker(
      markerId: MarkerId('12'),
      position: LatLng(13.0302251, 77.560721),
    )
  ];

  final List<LatLng> __latlng = <LatLng>[
    LatLng(13.0302251, 77.560721),
    LatLng(13.029448, 77.660831),
    LatLng(13.014199, 77.5560831),
    LatLng(13.049448, 77.630831),
    LatLng(13.009448, 77.630831),
    LatLng(13.009448, 73.630831),
  ];

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.029448, 77.560831),
    zoom: 11,
  );

  static final Marker _kGooglePlexMarker1 = Marker(
    markerId: MarkerId('_kGooglePlex1'),
    infoWindow: InfoWindow(title: 'Mysore Palace', onTap: () {}),
    position: LatLng(13.029448, 77.560831),
    icon: BitmapDescriptor.defaultMarker,
  );

  static final Marker _kGooglePlexMarker2 = Marker(
    markerId: MarkerId('_kGooglePlex2'),
    infoWindow: InfoWindow(title: 'M G Road', onTap: () {}),
    position: LatLng(13.030251, 77.560721),
    icon: BitmapDescriptor.defaultMarker,
  );

  static final CameraPosition _kLake = CameraPosition(
    target: LatLng(37.9756565685865, -122.099796966523),
    zoom: 14.4746,
  );

  Uint8List? markerImage;

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      __markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: __latlng[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: '@person12 :' + i.toString(),
          )));

      setState(() {
        markerIcon;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(11),
                child: Column(
                  children: [
                    SizedBox(
                      height: 48,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sarathee",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF062833),
                                  letterSpacing: 2),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF27444D),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      ContactScreen.idScreen, (route) => false);
                                },
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                child: ChangeThemeButtonWidget(),
                                // child: Container(
                                //   height: 40,
                                //   width: 40,
                                //   decoration: BoxDecoration(
                                //       color: Color(0xFF27444D),
                                //       borderRadius: BorderRadius.all(
                                //           Radius.circular(8))),
                                //   child: Icon(
                                //     Icons.notification_add_rounded,
                                //     color: Colors.white,
                                //   ),
                                // ),
                                onTap: () {
                                  // ThemeProvider();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    CarouselSlider(
                      items: [
                        GestureDetector(
                          child: Container(
                            // ignore: sort_child_properties_last
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 52,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Banglore Palace",
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                    ),
                                    const SizedBox(
                                      width: 45,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        "More  ",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF0D3C4B))),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          SizedBox(
                                            width: 19,
                                          ),
                                          const Icon(Icons.arrow_circle_right),
                                          const SizedBox(
                                            width: 100,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 220,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            height: 200,
                            width: 315,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("images/banglore-palace.jpg"),
                                  fit: BoxFit.fill),
                              // color: Color(0xFFA7C5CE),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 14.0,
                                    color: Color.fromARGB(255, 198, 194, 194),
                                    offset: Offset(
                                      0,
                                      0,
                                    )),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                        Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    "Church\nMysore",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: ui.Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize: 26,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 62,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          height: 200,
                          width: 315,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "images/church-mysore.png",
                                ),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFB1AD37)),
                        ),
                        Container(
                          // ignore: sort_child_properties_last
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 9,
                                  ),
                                  Text(
                                    "Church \nStreet",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          height: 200,
                          width: 315,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "images/church-street.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 14.0,
                                  color: Color.fromARGB(255, 198, 194, 194),
                                  offset: Offset(
                                    0,
                                    0,
                                  )),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 154.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 8, 0, 0),
                                  child: Text(
                                    "Community",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "images/emergency.png",
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 13,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 8, 8, 8),
                                  child: Text(
                                    "Checkout our Travel Commuitity\n  and be a part of it",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                ),
                              ],
                            )
                          ],
                        ),
                        height: 250,
                        width: 350,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(255, 198, 194, 194),
                              Colors.red,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 14.0,
                                color: ui.Color.fromARGB(255, 164, 161, 161),
                                offset: Offset(
                                  10,
                                  10,
                                )),
                          ],
                          color: ui.Color.fromARGB(255, 189, 157, 222),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            CommunityScreen.idScreen, (route) => false);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(13, 15, 15, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 15, 0, 18),
                                    child: Text(
                                      "Travel Guide",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Image.asset(
                                    "images/mobile.png",
                                    height: 60,
                                    width: 60,
                                  ),
                                ],
                              ),
                              height: 140,
                              width: 150,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 14.0,
                                      color: Color.fromARGB(255, 198, 194, 194),
                                      offset: Offset(
                                        10,
                                        10,
                                      ),
                                    ),
                                  ],
                                  color: Color(0xFFA7C5CE),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  optionMobileICU.idScreen, (route) => false);
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 15, 0, 18),
                                    child: Text(
                                      "Search Places",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Image.asset(
                                    "images/intercity.png",
                                    height: 60,
                                    width: 60,
                                  )
                                ],
                              ),
                              height: 140,
                              width: 150,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 14.0,
                                        color:
                                            Color.fromARGB(255, 198, 194, 194),
                                        offset: Offset(
                                          10,
                                          10,
                                        )),
                                  ],
                                  color: Color(0xFFA7C5CE),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  MobileIcuService.idScreen, (route) => false);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 23,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Nearby Tourists",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF062833),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle,
                          color: Color(0xFF062833),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      height: 220,
                      width: 330,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 14.0,
                            color: Color.fromARGB(255, 198, 194, 194),
                            offset: Offset(
                              10,
                              10,
                            )),
                      ], borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        child: GoogleMap(
                          padding: EdgeInsets.only(bottom: 0),
                          mapType: MapType.normal,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          markers: Set<Marker>.of(__markers),
                          initialCameraPosition: _kGooglePlex,
                          compassEnabled: true,
                          myLocationButtonEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                            _controllerGoogleMap.complete(controller);
                            newGoogleMapController = controller;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: GestureDetector(
                        child: Container(
                          height: 120,
                          width: 350,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 14.0,
                                    color: Color.fromARGB(255, 198, 194, 194),
                                    offset: Offset(
                                      10,
                                      10,
                                    )),
                              ],
                              color: Color(0xFF8D689E),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 14, 0, 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Update Your\nTravel Documents",
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Image.asset(
                                    "images/hospital.png",
                                    height: 50,
                                    width: 50,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              medicalFilesScreen.idScreen, (route) => false);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF062833),
                          shape: const StadiumBorder(),
                        ),
                        child: Container(
                          height: 50.0,
                          width: 100.0,
                          padding: const EdgeInsets.all(13.0),
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: "Brand Bold",
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(context,
                              GetStartedScreen.idScreen, (route) => false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xFF677F87),
            selectedItemColor: Colors.green,
            items: [
              BottomNavigationBarItem(
                  icon: IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: Color(0xFF062833),
                      size: 30,
                    ),
                    onPressed: () => {
                      scaffoldKey.currentState?.openDrawer(),
                    },
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: IconButton(
                    icon: const Icon(
                      Icons.home_rounded,
                      color: Color(0xFFFFFFFF),
                      size: 30,
                    ),
                    onPressed: () => {
                      Scaffold.of(context).openDrawer(),
                    },
                  ),
                  label: ''),
            ],
          ),
        ),
      ],
    );
  }
}
//42 header to blurbutton
