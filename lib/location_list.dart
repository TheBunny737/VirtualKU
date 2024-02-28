import 'package:flutter/material.dart';
import 'package:virtualku/location_details.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  TextEditingController _searchController = TextEditingController();
  List<Location> locations = [
    Location(
      name: 'อาคาร 45 ปีคณะวิทยาศาสตร์',
      landmark: 'Landmark 1',
      details: 'Details of Location 1',
      imagePath: 'assets/images/location1.jpg',
    ),
    Location(
      name: 'ภาควิชาวิทยาการคอมพิวเตอร์',
      landmark: 'Landmark 2',
      details: 'Details of Location 2',
      imagePath: 'assets/images/location2.jpg',
    ),
    // Add more locations as needed
  ];
  List<Location> filteredLocations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    filteredLocations.clear();
                  } else {
                    filteredLocations = locations
                        .where((location) => location.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  }
                });
              },
              decoration: InputDecoration(
                hintText: 'Search locations...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredLocations.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredLocations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredLocations[index].name),
                        leading: Image.asset(
                          filteredLocations[index].imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationDetails(
                                location: filteredLocations[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : Center(
                    child: Text('Type in the search field to find locations'),
                  ),
          ),
        ],
      ),
    );
  }
}

class Location {
  final String name;
  final String landmark;
  final String details;
  final String imagePath;

  Location({
    required this.name,
    required this.landmark,
    required this.details,
    required this.imagePath,
  });
}
