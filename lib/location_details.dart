import 'package:flutter/material.dart';
import 'package:virtualku/location_list.dart';

class LocationDetails extends StatelessWidget {
  final Location location;

  LocationDetails({required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Details'),
      ),
      body: Padding(
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
              location.imagePath, // Use the image path for the selected location
              width: 512, // Adjust width as needed
              height: 512, // Adjust height as needed
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
          ],
        ),
      ),
    );
  }
}