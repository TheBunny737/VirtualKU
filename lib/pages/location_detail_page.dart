import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_map_app/pages/ar_page.dart';
// import 'package:google_map_app/pages/location_list_page.dart';
import 'package:google_map_app/pages/google_map_page.dart';

class Location {
  final String name;
  final String landmark;
  final String details;
  final String imagePath;
  final double latitude; // Latitude of the location
  final double longitude; // Longitude of the location

  Location({
    required this.name,
    required this.landmark,
    required this.details,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
  });
}

class LocationDetails extends StatelessWidget {
  final Location location;
  final String name; // Add custom location name parameter

  LocationDetails({
    required this.location,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location: ${location.name}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                location.imagePath,
                width: 512,
                height: 512,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                'Landmark: ${location.landmark}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Details: ${location.details}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoogleMapPage(
                        destinationLatitude: location.latitude,
                        destinationLongitude: location.longitude,
                      ),
                    ),
                  );
                },
                child: Text('Set Location'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ARViewPage(
                        destinationLatitude: location.latitude,
                        destinationLongitude: location.longitude,
                        customLocationName: location.name, // Pass custom location name
                      ),
                    ),
                  );
                },
                child: Text('Go to AR Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}