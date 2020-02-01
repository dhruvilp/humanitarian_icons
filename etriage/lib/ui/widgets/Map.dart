import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../defaults.dart';
import '../../models/filestore.dart';

class MapWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapWidgetState();
  }
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller;
  Set<Marker> _markers;
  static Timer apiCallTimer;
  int idCounter = 0;

  @override
  void initState() {
    _controller = Completer();
    _markers = new Set();
    apiCallTimer = new Timer.periodic(Duration(seconds: 2), _updateMap);
  }

  void _updateMap(Timer t) async {
    var authToken = await getStoredCredential();
    Response response =
        await Dio().post(API + "/getLocations", data: {"token": authToken});
    print("Mapppp Tusting");

    idCounter = 0;
    for (var latlng in response.data['t1']) {
      addMarker(latlng, "assets/pink128_logo.png");
    }
    for (var latlng in response.data['t2']) {
      addMarker(latlng, "assets/yellow128_logo.png");
    }
    for (var latlng in response.data['t3']) {
      addMarker(latlng, "assets/green128_logo.png");
    }
    for (var latlng in response.data['t4']) {
      addMarker(latlng, "assets/black128_logo.png");
    }
  }

  void addMarker(String latlng, String assetStr) {
    double lat = double.parse(latlng.split(",")[0]);
    double lng = double.parse(latlng.split(",")[1]);
    print("$lat:$lng");

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(idCounter.toString()),
        icon: BitmapDescriptor.fromAsset(assetStr),
        position: LatLng(lat, lng),
      ));
    });

    idCounter++;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          print("hello created maps");
        },
        initialCameraPosition:
            CameraPosition(target: LatLng(40.5224362, -74.437561), zoom: 17),
        markers: _markers,
      ),
    );
  }
}
