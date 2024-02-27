// point_of_interest.dart
//flutteimport 'dart:convert';

class PointOfInterest {
  final String locations;
  final String image;
  final String latitude;
  final String longitude;
  final String entryFee;
  final String timings;
  final String category;
  // final List<String> category;
  final String descriptions;

  PointOfInterest({
    required this.locations,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.entryFee,
    required this.timings,
    required this.category,
    required this.descriptions,
  });

  factory PointOfInterest.fromJson(Map<String, dynamic> json) {
    return PointOfInterest(
      locations: json['locations'],
      image: json['image'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      entryFee: json['Entry Fee'],
      timings: json['Timings'],
      category: json['category'],
    // categories: List<String>.from(json['category']), // Change to List<String> 
      descriptions: json['Descriptions'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'locations': locations,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'Entry Fee': entryFee,
      'Timings': timings,
      'category': category,
      'Descriptions': descriptions,
    };
  /*  static List<PointOfInterest> filterByCategory(List<PointOfInterest> pointsOfInterest, String category) {
    return pointsOfInterest.where((poi) => poi.category ==category).toList();
  }*/
}
}
