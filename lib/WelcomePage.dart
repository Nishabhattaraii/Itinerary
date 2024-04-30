import 'package:flutter/material.dart';
import 'package:itinerary/Homepage.dart';
import 'package:itinerary/uihelper.dart';





class WelcomePage extends StatelessWidget {
//final String userLocation;

  



  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCircularStructure(),
          SizedBox(height: 20),
          UiHelper.CustomTextField(nameController, 'Enter your name', Icons.person, false),
          SizedBox(height: 10),
          UiHelper.CustomTextField(locationController, 'Enter your location', Icons.location_on, false),
          SizedBox(height: 20),
          UiHelper.CustomButton(() {
            // String name = nameController.text;
            String userLocation = locationController.text;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(userLocation: userLocation)),
            );
          }, 'Submit'),
        ],
      ),
    );
  }

  Widget _buildCircularStructure() {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 141, 80, 239), // Change color as needed
      ),
      child: Text(
        'TRAVEL',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          // Add more custom styling as needed
        ),
      ),
    );
  }
}
