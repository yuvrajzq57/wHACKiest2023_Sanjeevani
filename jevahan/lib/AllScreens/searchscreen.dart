import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jevahan/assistants/location_service.dart';
import 'package:jevahan/utilities/configMaps.dart';
import 'package:jevahan/utilities/progressDialog.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String idScreen = "searchscreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  final String key = "AIzaSyA3QShZcuKPRUuNI4uYH_iceRisE1ENLPM";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF062833),
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          // const SizedBox(
          //   height: 45,
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 200.0,
              width: 400,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(22.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 5.0),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Book your nearest ambulance",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF062833))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "images/user.png",
                          height: 16.0,
                          width: 16.0,
                        ),
                        //Pickup Point
                        SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: pickUpTextEditingController,
                                      decoration: InputDecoration(
                                        hintText: "Pickup Location",
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 11.0, top: 8.0, bottom: 8.0),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      LocationService().getPlace(
                                          pickUpTextEditingController.text);
                                    },
                                    icon: Icon(Icons.search),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Destination point
                    SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "images/user.png",
                          height: 16.0,
                          width: 16.0,
                        ),
                        SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Expanded(
                                child: TextField(
                                  controller: dropOffTextEditingController,
                                  decoration: InputDecoration(
                                    hintText: "Dropoff Location",
                                    fillColor: Colors.grey[300],
                                    filled: true,
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                        left: 11.0, top: 8.0, bottom: 8.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          //tile for displaying prediction
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
