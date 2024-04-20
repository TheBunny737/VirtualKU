import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector; // Import statement added
import 'package:geolocator/geolocator.dart';

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
        title: Text(
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
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'ระยะทาง: ${distanceToDestination?.toStringAsFixed(2) ?? "กำลังคำนวณ.."} เมตร',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.green.withOpacity(0.75),
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              widget.customLocationName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
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
      final marker = ArCoreNode(
        shape: ArCoreSphere(
          radius: 0.1,
          materials: [ArCoreMaterial(color: Colors.red)],
        ),
        position: vector.Vector3(0.0, 0.0, -5.0),
      );
      arCoreController!.addArCoreNode(marker); // Use the arCoreController instance to add the marker
    } catch (e) {
      print('Error adding marker node: $e');
    }
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
