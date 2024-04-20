import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

class ARViewPage extends StatefulWidget {
  final double destinationLatitude;
  final double destinationLongitude;
  final String customLocationName;

  const ARViewPage({
    Key? key,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.customLocationName,
  }) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AR Live View',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ArCoreView(
                  onArCoreViewCreated: _onArCoreViewCreated,
                  enableTapRecognizer: true,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.black.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Distance to Destination: ${distanceToDestination?.toStringAsFixed(2) ?? "Calculating..."} meters',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.green, // Set background color to green
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              widget.customLocationName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _getCurrentLocation();
    _addMarker(); // Call the method to add marker
  }

  void _addMarker() {
    try {
      // Calculate rotation angle between current location and destination
      double rotationAngle = _calculateRotationAngle();

      final marker = ArCoreNode(
        shape: ArCoreSphere(
          radius: 0.1,
          materials: [ArCoreMaterial(color: Colors.red)],
        ),
        position: vector.Vector3(0.0, 0.0, -5.0),
        rotation: vector.Vector4(0.0, math.sin(rotationAngle / 2), 0.0, math.cos(rotationAngle / 2)),
      );
      arCoreController!.addArCoreNode(marker); // Use the arCoreController instance to add the marker
    } catch (e) {
      debugPrint('Error adding marker node: $e');
    }
  }

  double _calculateRotationAngle() {
    if (currentPosition != null && destinationLatitude != null && destinationLongitude != null) {
      // Convert nullable doubles to non-nullable doubles
      double lat = destinationLatitude!;
      double lon = destinationLongitude!;

      // Calculate angle between current location and destination
      double dLon = lon - currentPosition!.longitude;
      double y = math.sin(dLon) * math.cos(lat);
      double x = math.cos(currentPosition!.latitude) * math.sin(lat) -
          math.sin(currentPosition!.latitude) * math.cos(lat) * math.cos(dLon);
      double angle = math.atan2(y, x);

      // Convert angle to radians
      return angle;
    }
    return 0.0;
  }

  @override
  void initState() {
    super.initState();
    destinationLatitude = widget.destinationLatitude;
    destinationLongitude = widget.destinationLongitude;
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
        _calculateDistance();
      });
    } catch (e) {
      debugPrint('Error getting current location: $e');
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
