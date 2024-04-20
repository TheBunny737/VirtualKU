import 'dart:io';

import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:geolocator/geolocator.dart';

// void main() {
//   runApp(MyApp());
// }

class ARViewPage extends StatefulWidget {
  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> {
  ArCoreController? arCoreController;
  Position? currentPosition;
  double? destinationLatitude;
  double? destinationLongitude;
  double? distanceToDestination;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // Example destination coordinates (Change as needed)
    destinationLatitude = 13.849805372964815;
    destinationLongitude = 100.56830608503942;
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Live View'),
      ),
      body: Stack(
        children: [
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Distance to Destination: ${distanceToDestination?.toStringAsFixed(2) ?? "Calculating..."} meters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addMarker(arCoreController!);
  }

  void _addMarker(ArCoreController controller) {
    try {
      final marker = ArCoreNode(
        shape: ArCoreSphere(radius: 0.1, materials: [ArCoreMaterial(color: Colors.red)]),
        position: vector.Vector3(0.0, 0.0, -5.0),
      );
      controller.addArCoreNode(marker);
    } catch (e) {
      print('Error adding marker node: $e');
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
        _calculateDistance();
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  void _calculateDistance() {
    if (currentPosition != null && destinationLatitude != null && destinationLongitude != null) {
      double distance = Geolocator.distanceBetween(
        currentPosition!.latitude,
        currentPosition!.longitude,
        destinationLatitude!,
        destinationLongitude!,
      );
      setState(() {
        distanceToDestination = distance;
      });
    }
  }
}