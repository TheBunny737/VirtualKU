import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  final Map<String, int> locationStats;

  const StatisticsPage({Key? key, required this.locationStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Statistics'),
      ),
      body: ListView.builder(
        itemCount: locationStats.length,
        itemBuilder: (context, index) {
          final locationName = locationStats.keys.elementAt(index);
          final clickCount = locationStats.values.elementAt(index);
          return ListTile(
            title: Text(locationName),
            trailing: Text('$clickCount views'),
          );
        },
      ),
    );
  }
}
