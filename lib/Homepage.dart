import 'dart:convert';
//import 'dart:html' as html;
//import 'WelcomePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:itinerary/Function.dart';
import 'PointOfInterest.dart';
import 'package:itinerary/datamodel.dart';

class HomePage extends StatefulWidget {
  final String userLocation; 

  const HomePage({Key? key,required this.userLocation}) : super(key: key);
//const HomePage({Key? key, required this.userLocation}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedPreferences = [];
  List<PointOfInterest> selectedPOIs = [];
  List<String> dataList = [];
  String url = '';
  var data;//to store output returned
  String output = 'Initial Output';
  List<DataModel> itinerary = [];


  @override
  Widget build(BuildContext context) {
    String userLocation = widget.userLocation; 
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Your Interests"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Your build methods here
             buildPreferenceButton(context, "Religious places", "religious places"),
            SizedBox(height: 10),
            buildPreferenceButton(context, "Historical places", "historical places"),
            SizedBox(height: 10),
            buildPreferenceButton(context, "Natural places", "natural places"),
            SizedBox(height: 10),
            buildPreferenceButton(context, "Recreational places", "recreational places"),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                navigateToPOIs(context, selectedPreferences, userLocation);
              },
              child: Text(

                "Show Selected Preferences",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget buildPreferenceButton(BuildContext context, String title, String preference) {
  IconData iconData;
  Color iconColor;

  // Determine icon and color based on preference
 switch (preference) {
    case "religious places":
      iconData = Icons.temple_buddhist; // You can change this to a temple icon
      iconColor = Color.fromARGB(255, 247, 247, 249);
      break;
    case "historical places":
      iconData = Icons.villa;
      iconColor = Color.fromARGB(255, 247, 247, 249);
      break;
    case "natural places":
      iconData = Icons.forest; // You can change this to a leaves icon
      iconColor = Color.fromARGB(255, 247, 247, 249);
      break;
    case "recreational places":
      iconData = Icons.directions_bike;
      iconColor =  Color.fromARGB(255, 247, 247, 249);
      break;
    default:
      iconData = Icons.place;
      iconColor = Color.fromARGB(255, 247, 247, 249);
  }

  // Your buildPreferenceButton method here
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Checkbox(
          value: selectedPreferences.contains(preference),
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                selectedPreferences.add(preference);
                // Add the corresponding location to the dataList
                dataList.add(preference); 
                print(dataList);
              } else {
                selectedPreferences.remove(preference);
                dataList.remove(preference);
              }
            });
          },
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                if (!selectedPreferences.contains(preference)) {
                  selectedPreferences.add(preference);
                } else {
                  selectedPreferences.remove(preference);
                }
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                   Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Icon(
                  iconData,
                  color: iconColor,
                  size: 23, // Adjust the size of the icon as needed
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
void navigateToPOIs(BuildContext context, List<String> selectedPreferences, userLocation) async {
    List<PointOfInterest> poiList = await _parsePOIList();
    List<PointOfInterest> selectedPOIs = [];


    // Filter POIs based on preference category
    List<PointOfInterest> filteredPOIs = poiList.where((poi) => selectedPreferences.contains(poi.category)).toList();

        Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Explore Your Next Destination'),
          ),
          body: ListView.builder(
            itemCount: filteredPOIs.length,
            itemBuilder: (context, index) {
              var poi = filteredPOIs[index];
              return ListTile(
                title: Row(
                  children: [
                    Checkbox(
                    //  value: selectedPOIs.contains(poi),
                    value: selectedPOIs.map((e) => e.locations).contains(poi.locations),
                      onChanged: ( value) {
                        setState(() {
                          if (value != null && value) {
                           
                               selectedPOIs.add(poi);
                             
                          //  selectedPOIs = [poi];
                          } else {
                            selectedPOIs.remove(poi);
                          }
                        });
                      },
                    ),
                  
                    SizedBox(width: 10),
                    Text(
                      poi.locations,
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()  {
                       
            //  saveSelectedPOIsToJson(selectedPOIs);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectedPOIsPage(selectedPOIs: selectedPOIs, userLocation: userLocation),
                ),
              );
            },
            child: Icon(Icons.arrow_forward),
          ),
        ),
      ),
    );
  }

 


  Future<List<PointOfInterest>> _parsePOIList() async {
    String jsonData = await rootBundle.loadString('assets/POIlist.json');
    List<dynamic> jsonList = json.decode(jsonData);
    List<PointOfInterest> poiList = jsonList.map((json) => PointOfInterest.fromJson(json)).toList();
    return poiList;
  }

/*Future<List<String>> saveSelectedPOIsToJson(List<PointOfInterest> selectedPOIs) async {
    List<String> locationsList = selectedPOIs.map((poi) => poi.locations).toList();
    final jsonString = jsonEncode(locationsList);
    final blob = html.Blob([jsonString], 'application/json');
    final anchor = html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob));
    anchor.download = 'selected_pois.json';
    anchor.click();
    return locationsList;
  }
*/


 void _getDataFromGA(List<String> dataList) async {
    print(dataList);
    String jsonData = jsonEncode(dataList);
    String encodedData = Uri.encodeComponent(jsonData);
    url = 'http://127.0.0.1:5000/api?Query=$encodedData';

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingPage()),
    );

    try {
      data = await fetchdata(url);
      List<dynamic> jsonResponse = jsonDecode(data);
      itinerary = [];
      for (var data in jsonResponse) {
        itinerary.add(new DataModel(data['POI'], data['location'], data['image_url'],data['arrival_time'],data['leaving_time']));
      }
      Navigator.pop(context); // Pop the loading page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OutputPage(itinerary: itinerary),
        ),
      );
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        output = 'Error fetching data';
      });
    }
  }
}


class SelectedPOIsPage extends StatelessWidget {
  final List<PointOfInterest> selectedPOIs;
  final String userLocation;
  List<String> dataList = [];
 

  SelectedPOIsPage({Key? key, required this.selectedPOIs, required this.userLocation}) : super(key: key)
  {
    dataList.add(userLocation); 
    for (var poi in selectedPOIs){
  
      dataList.add(poi.locations);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected POIs'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedPOIs.length,
              itemBuilder: (context, index) {
                var poi = selectedPOIs[index];

                return ListTile(
                  title: Text(
                    poi.locations,
                    
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(poi: poi),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              
           //  final _HomePageState homePageState = context.findAncestorStateOfType<_HomePageState>()!;
              final jsonData = jsonEncode(dataList);
              String encodedData = Uri.encodeComponent(jsonData);
              String url = 'http://127.0.0.1:5000/api?Query=$encodedData';

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoadingPage()),
              );
              try {
                var data = await fetchdata(url);
                List<dynamic> jsonResponse = jsonDecode(data);
                List<DataModel> itinerary = [];
                for (var data in jsonResponse) {
                  itinerary.add(DataModel(data['POI'], data['location'], data['image_url'],data['arrival_time'],data['leaving_time']));
                }
                Navigator.pop(context); // Pop the loading page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OutputPage(itinerary: itinerary),
                  ),
                );
              } catch (e) {
               // print('Error fetching data: $e');
              }
            },
            child: Text(
              "Let's get the journey started",
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}


  

class DetailsPage extends StatelessWidget {
  final PointOfInterest poi;

  const DetailsPage({Key? key, required this.poi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(poi.locations),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10), // Add space between app bar and content
            Text(
              'Entry Fee:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5), // Add space between sections
            Text(
              poi.entryFee,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20), // Add more space between sections
            Text(
              'Timings:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5), // Add space between sections
            Text(
              poi.timings,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20), // Add more space between sections
            Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5), // Add space between sections
            Text(
              poi.descriptions,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading'),
      ),
      body: Center(
        child: CircularProgressIndicator(), // Display a loading indicator
      ),
    );
  }
}



class OutputPage extends StatelessWidget {
  final List<DataModel> itinerary;

  const OutputPage({Key? key, required this.itinerary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itinerary'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(213, 217, 142, 246),
              Color.fromARGB(255, 215, 162, 236),
              Color.fromARGB(255, 242, 210, 254),
              Color.fromARGB(255, 239, 225, 245),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: itinerary.length,
                  itemBuilder: (context, index) {
                    // Determine if the index is even or odd
                    bool isEvenIndex = index.isEven;
                    bool isFirstIndex = index == 0;
                    print('index: $index');
                    print('isFirstIndex: $isFirstIndex');


                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left-aligned image for even indices
                        if(isFirstIndex)
                          Text(
                             'your journey start from ${ itinerary[index].location}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                          ),



                        if(!isFirstIndex)
                          
                          if (isEvenIndex)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                itinerary[index].image_url,
                                width: 150.0,
                                height: 150.0,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Text('Error loading image: $error');
                                },
                              ),
                            ),
                            SizedBox(height: 8.0),
                            SizedBox(width: 8.0),
                            if(!isFirstIndex)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itinerary[index].location,
                                  style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  ),
                                  textAlign: isEvenIndex ? TextAlign.start : TextAlign.end,
                                ),
                                SizedBox(height: 8.0),
                                SizedBox(width: 8.0),
                          
                              Text(
                                //itinerary[index].arrival_time,
                                'Arrival Time: ${itinerary[index].arrival_time}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                ),
                                textAlign: isEvenIndex ? TextAlign.start : TextAlign.end,
                              ),
                                 SizedBox(height: 8.0),
                          
                              Text(
                                //  itinerary[index].leaving_time,
                                'Leaving Time: ${itinerary[index].leaving_time}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: isEvenIndex ? TextAlign.start : TextAlign.end,
                                ),

                                ]
                                ),
                                // Right-aligned image for odd indices
                                if (!isEvenIndex)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      itinerary[index].image_url,
                                      width: 150.0,
                                      height: 150.0,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, progress) {
                                        if (progress == null) {
                                          return child;
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Text('Error loading image: $error');
                                      },
                                    ),
                                    
                                      ),
                                  
                                
                        ],
                      ),
                    );
                  },
                ),


              ),
            ],
          ),
        ),
      ),
    );
  }
}


