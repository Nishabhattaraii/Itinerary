import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Preferences"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildPreferenceButton(context, "Religious Places", () {
              // Add logic for handling the selection of religious places
            }),
            buildPreferenceButton(context, "Historical Places", () {
              // Add logic for handling the selection of historical places
            }),
            buildPreferenceButton(context, "Natural Places", () {
              // Add logic for handling the selection of natural places
            }),
            buildPreferenceButton(context, "Recreational Places", () {
              // Add logic for handling the selection of recreational places
            }),
            buildPreferenceButton(context, "Hiking and Trekking", () {
              // Add logic for handling the selection of hiking and trekking
            }),
          ],
        ),
      ),
    );
  }

  Widget buildPreferenceButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
