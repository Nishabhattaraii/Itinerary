// point_of_interest.dart
import 'package:flutter/material.dart';

class PointOfInterest {
  final String locations;
  final String image;
  final String latitude;
  final String longitude;
  final String entryFee;
  final String timings;
  final String category;
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
      descriptions: json['Descriptions'],
    );
  }
    static List<PointOfInterest> filterByCategory(List<PointOfInterest> pointsOfInterest, String category) {
    return pointsOfInterest.where((poi) => poi.category ==category).toList();
  }
}
