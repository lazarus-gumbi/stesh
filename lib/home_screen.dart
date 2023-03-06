import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:stesh/custom_dialog_box.dart';
import 'package:stesh/secrets.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  // variables declared here

  TextEditingController fromAddress = TextEditingController();
  TextEditingController toAddress = TextEditingController();

  GoogleMapController? _controller;
  late Set<Marker> _markers = Set();

  late Position _currentPosition = "" as Position;

  var uuid = new Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];

  static final LatLng _kMapCenter = LatLng(-26.497616, 31.355667);
  static final CameraPosition _kInitialPosotion =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);
  var _textField;

  late LatLng fromAdd;
  late LatLng toAdd;

  final Set<Polyline> polyline = {};

  compute(LatLng start, LatLng end) async {
    List<LatLng> trip = [start, end];

    setState(() {});
    polyline.add(
      Polyline(
        polylineId: PolylineId("1"),
        points: trip,
        color: Colors.amber,
      ),
    );
  }

  // handle bottom navigation and page switching

  //onchanged listener on the text controllers
  @override
  void initState() {
    super.initState();
    _getUserPosition();

    fromAddress.addListener(() {
      _source_onChanged();
    });

    toAddress.addListener(() {
      _destination_onChanged();
    });
  }

  _source_onChanged() {
    _textField = 'source';
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(fromAddress.text);
  }

  _destination_onChanged() {
    _textField = 'destination';
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(toAddress.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = Secrets.API_KEY;
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        // print(json.decode(response.body));
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getUserPosition() async {
    late Position pos;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      pos = position;
    }).catchError((e) {
      debugPrint(e);
    });

    _currentPosition = pos;
  }

  Future<void> getAddress() async {
    List<Placemark> currentPlace = await placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    // print(currentPlace[1]);
    fromAddress.text =
        '${currentPlace[1].street},${currentPlace[1].locality},${currentPlace[1].administrativeArea}';
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await _getUserPosition();
    _markers.add(
      Marker(
          markerId: MarkerId(_currentPosition.toString() ?? ""),
          position:
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
          icon: BitmapDescriptor.defaultMarker),
    );
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 17)),
    );
    await getAddress();
  }

  Future<void> getCordinates(String start_address, String end_address) async {
    final s_locations = await locationFromAddress(start_address);
    final e_locations = await locationFromAddress(end_address);
    print(s_locations.first.latitude);
    print(e_locations.first.latitude);
    _markers = Set();

    fromAdd = LatLng(s_locations.first.latitude, s_locations.first.longitude);
    toAdd = LatLng(e_locations.first.latitude, e_locations.first.longitude);

    _markers.add(
      Marker(
          markerId: MarkerId(s_locations.toString()),
          position:
              LatLng(s_locations.first.latitude, s_locations.first.longitude),
          icon: BitmapDescriptor.defaultMarker),
    );
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(s_locations.first.latitude, s_locations.first.longitude),
      )),
    );
    _markers.add(
      Marker(
          markerId: MarkerId(e_locations.toString()),
          position:
              LatLng(e_locations.first.latitude, e_locations.first.longitude),
          icon: BitmapDescriptor.defaultMarker),
    );

    compute(fromAdd, toAdd);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kInitialPosotion,
              onMapCreated: (controller) {
                _controller = controller;
              },
              myLocationEnabled: true,
              markers: _markers,
            ),
            Container(
              color: Color(0xff333333),
              // height: 100,
              padding: EdgeInsets.fromLTRB(15, 40, 20, 20),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(
                                  Icons.location_on,
                                  color: Color(0xffffa700),
                                ),
                                onPressed: () {
                                  _getCurrentPosition();
                                },
                              )),
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: fromAddress,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Where From?",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                width: 10,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.more_vert,
                              color: Color(0xff757575),
                              size: 25,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: SizedBox(),
                          ),
                          Expanded(
                              child: SizedBox(
                            width: 10,
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.circle,
                                color: Color(0xff757575),
                                size: 20,
                              )),
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: toAddress,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Where To?",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                getCordinates(fromAddress.text, toAddress.text);

                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                //TODO: the button should then submit the from and to addresses
                                //TODO: implement path drawing
                                //Display details
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return (CustomDialogBox(
                                        fromAddress: fromAddress.text,
                                        toAddress: toAddress.text,
                                      ));
                                    });
                              },
                              icon: Icon(
                                Icons.search,
                                color: Color.fromRGBO(255, 167, 0, 1),
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_placeList[index]["description"]),
                        onTap: () {
                          if (_textField == 'source') {
                            fromAddress.text = _placeList[index]["description"];
                          } else if (_textField == 'destination') {
                            toAddress.text = _placeList[index]["description"];
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
