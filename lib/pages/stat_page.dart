import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  final Map<String, int> locationStats;

  const StatisticsPage({Key? key, required this.locationStats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert locationStats map to a list of key-value pairs
    List<MapEntry<String, int>> sortedEntries = locationStats.entries.toList();

    // Sort the list based on view counts
    sortedEntries.sort((a, b) => b.value.compareTo(a.value));

    // Find the maximum click count
    int maxClickCount = sortedEntries.isNotEmpty ? sortedEntries.first.value : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Statistics'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: sortedEntries.length,
        itemBuilder: (context, index) {
          final locationName = sortedEntries[index].key;
          final clickCount = sortedEntries[index].value;
          // Calculate the width of the bar based on the click count relative to the maximum
          double barWidth = (clickCount / maxClickCount) * MediaQuery.of(context).size.width * 0.8;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locationName),
                const SizedBox(height: 8),
                Container(
                  width: barWidth,
                  height: 20,
                  color: Colors.green, // Use any color you prefer
                  child: Center(
                    child: Text('$clickCount views', style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}