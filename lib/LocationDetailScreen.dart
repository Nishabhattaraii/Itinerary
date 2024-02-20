import 'package:flutter/material.dart';

class LocationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> poi;

  const LocationDetailsScreen({Key? key, required this.poi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(poi['locations']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entry Fee: ${poi['Entry Fee']}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Timings: ${poi['Timings']}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Text(poi['Descriptions']),
          ],
        ),
      ),
    );
  }
}
