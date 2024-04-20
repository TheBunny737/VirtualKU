import 'package:flutter/material.dart';
import 'package:google_map_app/pages/location_detail_page.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> locations = [
    Location(
      name: 'อาคาร 45 ปีคณะวิทยาศาสตร์',
      landmark: 'อยู่ตรงข้ามกับคณะวิศวกรรมศาสตร์',
      details: 'อาคารรวมสำหรับสาขาในคณะวิทยาศาสตร์',
      imagePath: 'assets/images/location1.jpg',
      latitude: 13.84575754518484, // Latitude of the location
      longitude: 100.57129248576203, // Longitude of the location
    ),
    Location(
      name: 'อาคารจักรพันธ์เพ็ญศิริ',
      landmark: 'อาคารขนาดใหญ่อยู่ติดกับศูนย์เรียนรวม 2 3 และ 4',
      details: 'อาคารขนาดใหญ่',
      imagePath: 'assets/images/location2.jpg',
      latitude: 13.849805372964815, // Example latitude
      longitude: 100.56830608503942, // Example longitude
    ),
    Location(
      name: 'โรงอาหารกลาง 1 ',
      landmark: '(บาร์ใหม่)',
      details: 'เปิดให้บริการทุกวัน ไม่เว้นวันหยุดราชการ',
      imagePath: 'assets/images/canteen1.jpg',
      latitude: 13.848758084002498,  // Example latitude
      longitude: 100.5670858420261, // Example longitude
    ),
    Location(
      name: 'โรงอาหารกลาง 2 ',
      landmark: '(บาร์ใหม่กว่า)',
      details: 'เปิดให้บริการวันจันทร์ – วันเสาร์ หยุดวันอาทิตย์',
      imagePath: 'assets/images/canteen2.jpg',
      latitude: 13.852029898424115,   // Example latitude
      longitude: 100.57180624659613, // Example longitude
    ),
    Location(
      name: 'KU AVENUE ',
      landmark: '(Community Mall ที่รวมร้านอาหาร เครื่องดื่ม ร้านจำหน่ายผัก ผลไม้ และบริการทันตกรรม สื่อสิ่งพิมพ์)',
      details: 'เ เปิดให้บริการทุกวัน ไม่เว้นวันหยุดราชาการ เวลา06.00-21.00',
      imagePath: 'assets/images/KUAvenue.jpg',
      latitude: 13.846141247242452,    // Example latitude
      longitude: 100.56485419807169, // Example longitude
    ),
  ];
  List<Location> filteredLocations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
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
              decoration: const InputDecoration(
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
                          name: filteredLocations[index].name, // Provide customLocationName
                        ),
                      ),
                    );
                  },
                );
              },
            )
                : const Center(
              child: Text('Type in the search field to find locations'),
            ),
          ),
        ],
      ),
    );
  }
}

// class Location {
//   final String name;
//   final String landmark;
//   final String details;
//   final String imagePath;
//   final double latitude; // Latitude of the location
//   final double longitude; // Longitude of the location
//
//   Location({
//     required this.name,
//     required this.landmark,
//     required this.details,
//     required this.imagePath,
//     required this.latitude,
//     required this.longitude,
//   });
// }