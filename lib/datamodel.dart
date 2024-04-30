class DataModel{
  final int POI;
  final String location;
  final  image_url;
  final arrival_time;
  final leaving_time;

  DataModel(this.POI, this.location, this.image_url, this.arrival_time, this.leaving_time);

  // DataModel.fromJson(Map<String, dynamic> json)
  // {
  //   POI = json['POI'];
  //   location = json['location'];
  // } 
}