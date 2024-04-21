import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
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
                      'ระยะทาง: ${distanceToDestination?.toStringAsFixed(2) ?? "กำลังคำนวณ.."} เมตร',
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
                fontSize: 16,
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
    _addSphere();
    _addCylinder(controller);
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

  void _addSphere() {
    if (arCoreController != null) {
      final sphere = ArCoreSphere(
        materials: [ArCoreMaterial(color: Colors.red)],
        radius: 0.07,
      );
      final node = ArCoreNode(
        shape: sphere,
        position: vector.Vector3(0, 0, -1), // Example position, adjust as needed
      );
      arCoreController!.addArCoreNode(node);
    }
  }

  void _addCylinder(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.green,
      reflectance: 1.0,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.25,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    controller.addArCoreNode(node);
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