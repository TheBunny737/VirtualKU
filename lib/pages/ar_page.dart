import 'dart:io';

import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARViewPage extends StatefulWidget {
  final double destinationLatitude;
  final double destinationLongitude;

  const ARViewPage({
    Key? key,
    required this.destinationLatitude,
    required this.destinationLongitude,
  }) : super(key: key);

  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> {
  ArCoreController? arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR View'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addMarker(arCoreController!);
    // _addArrow(arCoreController!);
  }

  Future<void> _addMarker(ArCoreController controller) async {
    try {
      final material = ArCoreMaterial(color: Colors.red, metallic: 1.0);
      final marker = ArCoreNode(
        shape: ArCoreSphere(materials: [material], radius: 0.05),
        position: vector.Vector3(0.0, 0.0, -1.0),
      );
      controller.addArCoreNode(marker);
    } catch (e) {
      print('Error adding marker node: $e');
    }
  }

  // Future<void> _addArrow(ArCoreController controller) async {
  //   try {
  //     final arrowNode = ArCoreReferenceNode(
  //       name: 'arrow',
  //       objectUrl: 'assets/images/arrow.obj',
  //       position: vector.Vector3(0.0, 0.0, -1.0),
  //       scale: vector.Vector3(0.2, 0.2, 0.2),
  //     );
  //     controller.addArCoreNode(arrowNode);
  //   } catch (e) {
  //     print('Error adding arrow node: $e');
  //   }
  // }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}