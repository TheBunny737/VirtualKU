// import 'package:flutter/material.dart';
// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

// class ARNavigationMap extends StatefulWidget {
//   @override
//   _ARNavigationMapState createState() => _ARNavigationMapState();
// }

// class _ARNavigationMapState extends State<ARNavigationMap> {
//   late ArCoreController arCoreController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('AR Navigation Map'),
//       ),
//       body: ArCoreView(
//         onArCoreViewCreated: _onArCoreViewCreated,
//       ),
//     );
//   }

//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;
//     _addMarkers();
//   }

//   void _addMarkers() {
//     final List<ArCoreNode> markers = [];

//     // Add marker 1
//     markers.add(
//       ArCoreNode(
//         shape: ArCoreSphere(
//           radius: 0.1,
//           materials: [ArCoreMaterial(color: Colors.blue)],
//         ),
//         position: vector.Vector3(0, -1, -3),
//       ),
//     );

//     // Add marker 2
//     markers.add(
//       ArCoreNode(
//         shape: ArCoreSphere(
//           radius: 0.1,
//           materials: [ArCoreMaterial(color: Colors.red)],
//         ),
//         position: vector.Vector3(1, -1, -3),
//       ),
//     );

//     // Add all markers to the AR scene
//     markers.forEach((marker) {
//       arCoreController.addArCoreNode(marker);
//     });
//   }

//   @override
//   void dispose() {
//     arCoreController.dispose();
//     super.dispose();
//   }
// }