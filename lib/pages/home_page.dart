import 'package:flutter/material.dart';

import 'package:google_map_app/pages/location_list_page.dart';
import 'package:google_map_app/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), // Set button background color to green
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set text color to black
              ),
              onPressed: () {
                // Navigate to AR Navigation Map Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationList()),
                );
              },
              child: const Text('View Location'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), // Set button background color to green
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Set text color to black
              ),
              onPressed: () {
                // Navigate to Login Page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}