import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jevahan/AllScreens/bookedAmbulanceScreenICU.dart';
import 'package:jevahan/AllScreens/mainScreen.dart';
import 'package:jevahan/AllScreens/searchscreen.dart';
import 'package:jevahan/AllScreens/sideScreen.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_platform_interface/src/types/camera.dart';
import 'package:jevahan/assistants/location_service.dart';

class MobileIcuService extends StatefulWidget {
  static const String idScreen = "mobileicuservice";

  @override
  State<MobileIcuService> createState() => _MobileIcuServiceState();
}

class _MobileIcuServiceState extends State<MobileIcuService> {
  Position? _pickUpLocation;
  double? distanceInM = 0.0;
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  final String key = "AIzaSyA3QShZcuKPRUuNI4uYH_iceRisE1ENLPM";
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newGoogleMapController;

  late Position currentPosition;
  var geoLocator = Geolocator();

  double bottomPaddingOfMap = 0;
  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygon = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonlatLngs = <LatLng>[];

  int _polygonIdCounter = 1;
  int _polylineIdCounter = 1;

  static final CameraPosition _kGooglePlex = CameraPosition(
    bearing: 192.3456787653,
    target: LatLng(13.029448, 77.560831),
    zoom: 14.4746,
  );

  @override
  void intiState() {
    super.initState();

    _setMarker(LatLng(37.42796133580664, -122.085749655962));
  }

  void _setMarker(LatLng point) async {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('marker'),
        position: point,
      ));
    });
  }

  void _setPolygon() {
    final String polygonIdVal = 'polygon_$_polygonIdCounter';
    _polygonIdCounter++;

    _polygon.add(Polygon(
      polygonId: PolygonId(polygonIdVal),
      points: polygonlatLngs,
      strokeWidth: 2,
      fillColor: Colors.transparent,
    ));
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.red,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList()));
  }

  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 15000), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => bookedAmbulanceScreenICU()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF062833),
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
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: 67),
            mapType: MapType.normal,
            markers: _markers,
            polygons: _polygon,
            polylines: _polylines,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            compassEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              setState(() {
                bottomPaddingOfMap = 0.0;
              });
              // locatePosition();
            },
            onTap: (point) async {
              setState(() {
                polygonlatLngs.add(point);
                _setPolygon();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              child: Icon(Icons.my_location),
              onTap: () {},
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 200.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.0),
                  topRight: Radius.circular(22.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 66,
                      width: 319,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: pickUpTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Pickup Location",
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 11.0, top: 8.0, bottom: 8.0),
                                ),
                              ),
                            ),
                            // IconButton(
                            //   onPressed: () async {
                            //     var place = await LocationService()
                            //         .getPlace(pickUpTextEditingController.text);
                            //     _gotoDestionation(place);
                            //   },
                            //   icon: Icon(Icons.search),
                            // ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFD8ECF2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 66,
                      width: 319,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: dropOffTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Dropoff Location",
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 11.0, top: 8.0, bottom: 8.0),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                var directions =
                                    await LocationService().getDirections(
                                  pickUpTextEditingController.text,
                                  dropOffTextEditingController.text,
                                );

                                _gotoDestionation(
                                  directions['start_location']['lat'],
                                  directions['start_location']['lng'],
                                  directions['bounds_ne'],
                                  directions['bounds_sw'],
                                );

                                _setPolyline(directions['polyline_decoded']);
                              },
                              icon: Icon(Icons.search),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFD8ECF2),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _gotoDestionation(
    // Map<String, dynamic> place
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lat'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );

    _setMarker(LatLng(lat, lng));
  }

  // Future _getTheDistance() async {
  //   var latlng1 = const LatLng(13.0306, 77.5649);
  //   var latlng2 = const LatLng(12.8922, 77.5812);
  //   // LatLng _pickUpLocation =
  //   //     LocationService().getPlaceId(LatLng(latitude, longitude));

  //   distanceInM = await Geolocator.distanceBetween(
  //       start.latitude, start.longitude, finish.latitude, finish.longitude);

  //   return distanceInM;
  // }
}
