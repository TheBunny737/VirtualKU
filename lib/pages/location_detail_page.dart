
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

  const LocationDetails({super.key,
    required this.location,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location: ${location.name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                location.imagePath,
                width: 512,
                height: 512,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                'Landmark: ${location.landmark}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Details: ${location.details}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set button background color to green
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to black
                ),
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
                child: const Text('Set Location'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set button background color to green
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color to black
                ),
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
                child: const Text('Set Location AR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}