import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jevahan/AllScreens/applicationForm..dart';
import 'package:jevahan/AllScreens/mainScreen.dart';
import 'package:jevahan/AllScreens/mobileICUsearchService.dart';

import 'package:jevahan/assistants/location_service.dart';
import 'package:url_launcher/url_launcher.dart';

class bookedAmbulanceScreenICU extends StatefulWidget {
  static const String idScreen = "bookedAmbulanceScreenICU";

  const bookedAmbulanceScreenICU({super.key});

  @override
  State<bookedAmbulanceScreenICU> createState() =>
      _bookedAmbulanceScreenICUState();
}

class _bookedAmbulanceScreenICUState extends State<bookedAmbulanceScreenICU> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  Marker? _origin;
  Marker? _destination;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.029448, 77.560831),
    zoom: 11,
  );

  double bottomPaddingOfMap = 0;

  // void _setMarker(Lat)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, MobileIcuService.idScreen, (route) => false);
          },
        ),
        backgroundColor: Color(0xFF062833),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25.0, 15, 25, 15),
              child: Expanded(
                child: Text(
                  "Delhi -->  Taj Mahal ",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF062833)),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFD8ECF2),
              ),
              height: 100,
              width: 340,
              child: Center(
                child: Text(
                  "How to Reach?\n Bus , Train ,Cabs",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF062833)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 19,
            ),
            SizedBox(
              height: 440,
              child: Stack(
                children: [
                  GoogleMap(
                    padding: EdgeInsets.only(bottom: 2),
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    markers: {
                      if (_origin != null) _origin!,
                      if (_destination != null) _destination!,
                    },
                    onLongPress: _addMarker,
                    initialCameraPosition: _kGooglePlex,
                    compassEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapController = controller;
                      setState(() {
                        // bottomPaddingOfMap = 0.0;
                      });
                      // locatePosition();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                child: Text(
                  "Feedback Form",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF062833)),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      content: Text(
                        "Want to fill \nthe Feedback \nform?",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  "No",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF062833))),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    ApplicationForm.idScreen, (route) => false);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  "Yes",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF062833))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarker,
          position: pos,
        );
        _destination = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarker,
          position: pos,
        );
      });
    }
  }
}
