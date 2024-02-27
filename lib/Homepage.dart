import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> selectedPreferences = [];
  List<dynamic> selectedPOIs = [];

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
            buildPreferenceButton(context, "Religious Places", "religious places"),
            buildPreferenceButton(context, "Historical Places", "historical places"),
            buildPreferenceButton(context, "Natural Places", "natural places"),
            buildPreferenceButton(context, "Recreational Places", "recreational places"),
            buildPreferenceButton(context, "Hiking and Trekking", "hiking and trekking"),
            ElevatedButton(
              onPressed: () {
                navigateToPOIs(context, selectedPreferences);
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
                } else {
                  selectedPreferences.remove(preference);
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
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToPOIs(BuildContext context, List<String> selectedPreferences) {
    // Read and parse POIlist.json
      String jsonString = '[{"locations": "Pashupatinath Temple", "image": "", "latitude": "27.71057", "longitude": "85.34874", "Entry Fee": "USD 410.", "Timings": "Open 24 hours.", "category": "religious places", "Descriptions": "Hinduism is the most widely followed religion in Nepal. The country has embraced this religion and respects it with several sacred places of interest, including Pashupatinath Temple. The sacred place is considered one of the most important temples in the world and one of the most visited tourist places in Kathmandu. The complex is on UNESCO World Heritage Sites\u2019 list for decades. The extensive Hindu temple has a sprawling collection of images, inscriptions, ashrams, temples and images. There are 12 Jyotirlinga in India and the one in Nepal is the head over this body. The temple has 275 holy abodes of Shiva as well. Temple architecture is quite intriguing as it is built in Nepalese pagoda style of architecture. The wooden rafters are carved to perfection whereas the overall foundation is like cubic constructions. The sacro sanctum here is that of s stone Mukhalinga, or a linga with a face."}, {"locations": "Boudhanath (Stupa)", "image": "", "latitude": "27.72143", "longitude": "85.362", "Entry Fee": "Rs 250/ for foreigners", "Timings": "", "category": "religious places", "Descriptions": "A UNESCO World Heritage Site and one of the largest stupas in the world, the Boudhanath Stupa in Kathmandu is a significant place in Buddhism and architecture, both. Located on an ancient trade route that entered Kathmandu from Tibet.The place has seen many traders and travellers offering prayers to their lord here, as the Stupa is considered to be the tomb of the remains of Kassapa Buddha. With a lot of legends attached to the place, it is one of the best places to visit in Nepal and easily deserves to be called so."},{ "locations": "Swayambhunath Stupa", "image": "","latitude": "27.71494", "longitude": "85.29039", "Entry Fee": "Rs 200 for foreign nationals to go to the Swayambhu Stupa", "Timings": "Open 24 hours ", "category": "historical places", "Descriptions": "Situated on top of a hill in the Kathmandu Valley, this tourist place in Kathmandu is an ancient architectural marvel is one of the best attractions of the city. The entire complex is surrounded by a wide variety of trees. It comprises of the main stupa, many shrines, temples, monastery, museum and a wellstocked library.The temples are painted with the eyes and eyebrows of the Buddha with the number 1 in local script painted as the nose of the lord, which is a sight to behold in itself."}, { "locations": "Thamel","image": "", "latitude": "27.71703", "longitude": "85.31126", "Entry Fee": "Free","Timings": "From morning till night.","category": "recreational places","Descriptions": "A haven for tourists visiting Kathmandu, Thamel is a popular destination. The place has several hotels, shops and restaurants that are particularly designed to cater to a discerning range of customers.The commercial location is an easy walk from central Kathmandu and there are a number of activities that you can enjoy at this place.all its attractions makes it a place to visit in Kathmandu you cannot miss during your trip. The streets are quite fascinating at Thamel. But be cautious of sellers who might want to rip you off. Otherwise, the place is good for buying anything from Tibetan Singing Bowls to Glass Pipes. Just remember to bargain a little as the prices can come down to 2/3rdof the quoted prices.Here, you can also enjoy shopping incense sticks, Kukri swords, outdoor outfits and books. Over a hundred different eateries are located at this market. So, eat whatever cuisine you wish to try."} ,{"locations": "Kopan Monastery","image": "","latitude": "27.7422","longitude": "85.36388","Entry Fee": "Free entry.","Timings": "Open for tourists from morning to evening.","category": "religious places","Descriptions": "Founded by Lama Thubten Yeshe, who died in 1984, Kopan monastery is a sacred Buddhist site in the world. Located on the hilltop north of Bodhnath, the monastery is pleasant place where you can explore and study Buddhism.The monastery is still looking for the reincarnation of Lama Yeshe. However, the young Spanish boy, who was declared to be reincarnated Lama no longer resides at the Kopan Monastery. In fact, he renounced his vows and now works in Ibiza as a cinematographer. But that\u2019s not what\u2019s intriguing about the monastery. The place is best known for its books on Buddhist psychology and philosophy. Kopan is a pleasant walk from Bodhnath and Gokarna Mahadev Temple."},  { "locations": "Garden of Dreams","image": "","latitude": "27.71412", "longitude": "85.31481", "Entry Fee": "Rs 120 depending on adults or children.","Timings": "Open from 9 am to 10 pm. Last entry is at 9 pm.","category": "natural places","Descriptions": "The beautifully restored Swapna Baigicha, also known as Garden of Dreams is a popular tourist place in Kathmandu to visit offers respite and rejuvenation from the stresses of the world. It is one of the most stunning places in the world. The garden was built in the 1920s and has been brought back to life by the Austrian financed team. The stunningly restored garden has gorgeous and refined details.Some of the main highlights of this place includes marble inscription from Omar Khayam\u2019s Rubaiyat, beautiful fountains and ponds. The palace is home to a quirky \u2018hidden garden\u2019 as well. It also features three pavilions. The place is ideal for going out for a picnic or just to marvel at the humannature interaction. The place is a must visit for travelers."},{ "locations": "Durbar Square Kathmandu", "image": "", "latitude": "27.70452", "longitude": "85.30697","Entry Fee": "Fee Free","Timings": "From early morning to night.", "category": "Historical places","Descriptions": "Explore the culture or history of Kathmandu by visiting the Durbar Square. Located in front of the former Kathmandu Palace Kingdom, the Durbar Square is a UNESCO World Heritage Site and is originally known for vivid showcases of artists and craftsmen.The palace here is stunningly decorated and the overall areas reflect the beauty of Nepalese culture. The palaces and the square itself have gone through reconstruction on several occasions.People of finer taste should add this place to their list of best places to visit in Nepal trip. The place includes museum and other parts of the palace here are opened for visitors. The place is home to Kumari Chok as well it is one of the most curious attractions of Nepal. Here, a gilded cage contains Kumari, a girl who was chosen to be the human reincarnation of Hindu Goddess, Durga.this mere fact alone this place among places to visit near Kathmandu." }, { "locations": "Hanuman Dhoka Temple","image": "","latitude": "27.70423","longitude": "85.30754", "Entry Fee": "Rs 500 for SAARC Nationals, and Rs 1000 for other nationalities","Timings": "","category": "Historical places", "Descriptions": "A part of the Durbar Square of Kathmandu, it is a complex of buildings which consists of the royal palaces of Malla kings and the Shah Dynasty. Spread over a whopping 5 acres, the place gets its name from the standing statue of the Hindu Lord Hanuman on the entrance and lists among best tourist places in Kathmandu, \u201cDhoka\u201d in Nepali meaning door or gate.The statue itself dates back to 1672. The door is the entrance to the complex of Palace inside and is also the entryway to the Nasal Chok, Mul Chok, Mohan Chok and the Tribhuvan Museum, which exhibits the royal belongings of King Tribhuvan."},{"locations": "Kumari House","image": "","latitude": "27.70374", "longitude": "85.30654", "Entry Fee": "is free, however you will have to pay handlers to get an actual glimpse.", "Timings": "From mornings to evening.","category": "historical places","Descriptions": "It\u2019s a brick building located on the Durbar Square in Kathmandu. But the building goes beyond its architecture and has something quite intriguing to offer that\u2019s the spiritual reincarnation of Goddess Durga. It is believed that the girl housed in here is the living goddess of Kathmandu.Once upon a time, the temple was known for its magnificent carvings and divine inhabitants. Today it is mostly famous for being the house of a living goddess. Here, tourists will find woodcarved relics of gods and the symbols in Nepal and they can discover the place through a courtyard. Photos are strictly prohibited and it is forbidden to photograph the Kumari or the goddess. The living goddess does appear on the first floor windows often. But that happens in the morning or late afternoons. Kumari is a young girl and it is believed that in her expressions, she can answer the queries of devotees."},{"locations": "Buddha Nilkanth", "image": "", "latitude": "27.77809", "longitude": "85.36232", "Entry Fee": "","Timings": "5:00 AM to 6:00 PM", "category": "religious places", "Descriptions": "Budhanilkantha Temple is a hindu open air place of worship that is dedicated to Lord Vishnu. Located below the Shivapuri Hill at the northern end of Kathmandu Valley, this place is very much popular for its large reclining statue of Lord Vishnu.Being one of the most sought after tourist places in Kathmandu, it attracts zillions of visitors and devotees especially in large numbers during the occasion of Haribodhini Ekadashi Mela which is organised every single year on the 11th day of Kartik Month of the Hindu Calendar. Large reclining statue of Lord Vishnu" },{  "locations": "Narayanhiti Palace",  "image": "", "latitude": "27.71628", "longitude": "85.32028",  "Entry Fee": "", "Timings": "11 am to 4 pm", "category": "historical places", "Descriptions": "Want to know how the politics have transformed Nepal? Well, things will get a lot clearer when you visit the Narayanhiti Palace and Museum. Full of meeting rooms and 1970s glamour, the palace has opulent interiors. The place is well known for its museum beauty. Once, King Gyanendra lived in it, but he was given 15 days to vacate the property after his fall from the throne.This palace is also the place where Prince Dipendra massacred his family in 2001. The place is morbidly market and the bullet holes are still visible on some of the walls. But nevertheless, this place offers a peek into the regal lifestyle of the royals, the one that people only dream about."},{  "locations": "Indra Chowk", "image": "",  "latitude": "27.70594",  "longitude": "85.30967", "Entry Fee": "", "Timings": "Open from morning till evening.", "category": "religious places","Descriptions": "Makhan Tole\u2019s busy street spills and brings you closer to Indra Chowk, which is a popular courtyard in the region. The place, named after an ancient Vedic deity, Indra is known for its market and cultural escapades. It is here that you will find merchants of blankets and clothes, next door stone Shiva Temple and stunning fa\u00e7ade of the Akash Bhairab Temple. Apart from the market, one of the biggest highlights of this place is the Sky Temple. This particular temple has four metal lions that appear to be rearing over the street. It also includes two more brass lions at the entrance, where nonHindus can\u2019t enter. The market here, hidden in alleyways to the east are a must visit, especially if you want to eat some local food or wish to buy beads and bangles sold by the indigenous people of this region, making it a great tourist place in Kathmandu." }, { "locations": "Jagannath Temple", "image": "", "latitude": "27.69202", "longitude": "85.30258", "Entry Fee": "","Timings": "10:30 AM to 5:00 PM", "category": "religious places", "Descriptions": "Jagannath temple in Kathmandu Durbar Square is one of the most sought after Hindu places to visit in Kathmandu that is widely famous for its architectural designs and religious significance. The exotic carving on the body of the temple makes it one of the best tourist places in Kathmandu and in turn it attracts zillions of visitors all through the year.The temple was constructed in the middle of 16th century when the King Mahenda of the Malla Dynasty used to rule. The temple is a two storied building that is located on a raised platform and is constructed in a traditional pagoda style with wood and bricks. Architectural designs and religious significance" },{  "locations": "Freak Street","image": "","latitude": "27.70271", "longitude": "85.30766", "Entry Fee": "", "Timings": "",  "category": "historical places","Descriptions": "Freak Street happens to be a small street that is located to the South of Kathmandu Durbar Square. Once upon a time, this famous tourist place in Kathmandu was called the old freak street which refers to the hippie trail of 1960 and 1970s.This is no less than any other ordinary street in Kathmandu but it has got a good share of history and heritage attached to it. You will find a number of old shops and residences by the side of this road. Popular destination on 1960s/1970s hippie trail, drug selling"},{ "locations": "Kasthamandap", "image": "", "latitude": "27.704", "longitude": "85.30579", "Entry Fee": "",  "Timings": "", "category": "religious places","Descriptions": "Kasthamandap happens to be a three storied public shelter that houses a shrine consecrated to Gorakshanath situated at Maru. There are zillions of stories and myths connected to the construction of one of the most loved tourist places in Kathmandu.However, as per the recent developments found out after the earthquake in the year 2015 suggest that it was built in the 7th century during the Licchavi Era. The building was constructed from wood of a single sal tree and as per the legends, it was initially used as shelter but later it was converted into a place of worship. Architecture crafted from a single tree of Sal" },{"locations": "Asan","image": "", "latitude": "27.70939", "longitude": "85.31228", "Entry Fee": "is free. But you will have to pay for buying items.", "Timings": "Open from morning to evening.", "category": "recreational places", "Descriptions": "Asan, a shopper\u2019s delight is one of the main marketplaces in central Kathmandu, the capital city of Nepal. The place is a historic bazaar which has been popular for decades. The section is known for its festival calendar and strategic location as well. Streets at Asan converge in a square, which makes it a perpetual, bustling region. The colours here are vivid and bright, which makes it more enticing for the travellers. A variety of merchandise and diverse range of products are sold at this place, which makes it more exciting for travellers.Here, you can buy anything from spices to textiles, bullions, electronics and food items. The market is home to several architectural sights as well." },{ "locations": "Taudaha Lake", "image": "", "latitude": "27.64965","longitude": "85.28284", "Entry Fee": "", "Timings": "", "category": "natural places", "Descriptions": "It\u2019s time that you explore Kathmandu fair and square. Go for offbeaten tracks and trails and enjoy discovering Taudaha Lake. A small lake that\u2019s located in the outskirts of Kathmandu, Taudaha represents \u2018snake\u2019 and \u2018lake.\u2019 The name actually comes from mythology, where it is believed that a Buddhist mythical character Manjushree had cut the hill to drain the water of this lake, which is why the lake is now smaller than it used to be. However, due to the draining of lake, countless nagas, mythological creatures who were half snakes and half humans were left homeless.And therefore, an underwater lake or Taudaha was built, where serpent king and the subjects lived. That\u2019s why the lake is considered tranquil. This lake is perfect for birdwatchers, as a number of migratory species visit the place."}, {"locations": "Kathesimbhu Stupa","image": "", "latitude": "27.70957", "longitude": "85.3098", "Entry Fee": "There is no admission charges for entry into the stupa complex", "Timings": "The complex is opened for public access the entire day throughout the week.", "category": "historical places", "Descriptions": "The 17thcentury rendition of the renowned Swayambhunath temple, Kathesimbhu Stupa is one of the most popular Tibetan pilgrimage sites in Kathmandu. Located between Thamel and Durbar Square, the stupa was built using the left over materials from Swayambhunath temple complex.It is set in a hidden courtyard, surrounded by smaller stupas, engravings and statutes. Although well maintained and intact, this UNESCO World Heritage Site witnessed minor damages in the 2015 earthquake. In the northwestern corner of the courtyard there\u2019s a beautiful pagoda dedicated to Hariti, the goddess of smallpox whereas the northeast corner is adorned with the Drubgon Jangchup Choeling Monastery."},{ "locations": "Dakshinkali Temple", "image": "","latitude": "27.60526","longitude": "85.26349","Entry Fee": "", "Timings": "", "category": "religious places", "Descriptions": "Dakshinkali Temple is one of the major Hindu Shrines in the city of Kathmandu which is dedicated to Goddesses Kali. The name and fame of one of the best places to visit near Kathmandu is due to the rituals and traditions followed. There are animal sacrifices in every fortnight.The place of worship was constructed by Rani Rashmoni who was a great devotee of the fierce and feared Goddesses Kali. You can find the idol of the temple standing on top of a corpse portraying the victory of good over evil. Rituals and traditional approach of Worship"},{"locations": "National Museum of Nepal","image": "","latitude": "27.7055", "longitude": "85.28914", "Entry Fee": "Rs 300","Timings": "10:30 am to 4:30 pm.", "category": "historical places","Descriptions": "Close to Swayambhunath, one of the most beautiful monasteries in the world lies a sprawling museum in a walled compound. This National Museum has some of the most interesting treasures on display, which makes Chhauni Museum a tourist place in Kathmandu worth a visit.In the museum compound, you will find Judda Art Gallery, which is home to exquisite metal, terracotta and stone statues of Nepali deities. There are fabulous cloth paintings here as well. The place has a life sized statue of Jayavarma as well. The statue, discovered in 1992 is over 1800 years old. This museum includes temple styled Buddhist Art Gallery as well. The place has everything from manuscripts to informative displays and stone depiction of Buddha to offer. This place is home to leather cannons as well, seized during the 1792 NepalTibet War."}, {"locations": "White Monastery", "image": "", "latitude": "27.72358","longitude": "85.36908", "Entry Fee": "The usual price is USD 1.","Timings": "The place is open from morning to evening only on Saturdays.", "category": "religious places", "Descriptions": "Nepal holds a prominent place in Buddhist culture. The country has a number of monasteries, including Seto Gumba or the White Monastery. This is a natural beauty with the relevant religious importance. The white monastery is surrounded by lush green valley and vivid terrain which makes it such a delight to watch and a must place you cannot miss to visit in Kathmandu. The White Monastery gives heavenly pleasure and provides bird eye\u2019s view of the Kathmandu Valley. One of the main highlights of this monastery is its white colour as well as the serenity and calmness that it has to offer. The monastery has several murals, statues and paintings that can provide indepth information about Buddhism. The place is on offbeaten track but located close to the Swoyambhunath Stupa." }, {"locations": "Bajrayogini Temple","image": "", "latitude": "27.74378","longitude": "85.46723","Entry Fee": "","Timings": "", "category": "religious places","Descriptions": "Bajrayogini Temple happens to be a Tantrik Temple which is dedicated to the Buddhist Tantric Goddess in Nepal. This place is also known as Bodhisattvas Temple. In order to reach the temple complex and one of the best places to visit in Kathmandu, you would need to climb up a stone stairway.The best part of this temple is its fascinating setting in the midst of the alluring natural beauty. The complex of the best tourist places in Kathmandu has stonework, metal work, wood carving, caves, and stupas that date back to the time of the Buddha Shakyamuni. Stonework, metal work, wood carving"},{ "locations": "Royal Botanical Gardens","image": "","latitude": "27.59699", "longitude": "85.38327","Entry Fee": "", "Timings": "", "category": "natural places","Descriptions": "Kathmandu can get quite crowded during the holidays. But if you want someplace peaceful and quiet, then there\u2019s a perfect spot for you. It is the Royal Botanical Gardens. The place is quaint and great for walking and picnic. However, you might want to avoid it on Fridays and Saturdays, as schoolkids often visit the place then. While the place was slightly damaged during the earthquake, repairs are going on and the place will be back to its glory.One of the main highlights of this place is the visitor center, where you can experience an enormous variety of Nepal\u2019s flora. The place includes cactus house, orchid house and a tropical house as well. In the middle of the center is the coronation pond, with a pillar. Add the Botanical Garden in the list of places to visit in Kathmandu, if you want to enjoy the beautiful nature in Nepal."}]';
  

    List<dynamic> poiList = json.decode(jsonString);

    // Filter POIs based on preference category
    List<dynamic> filteredPOIs = poiList.where((poi) => selectedPreferences.contains(poi['category'])).toList();

    // Navigate to POI list screen with filtered POIs
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Filtered POIs'),
          ),
          body: ListView.builder(
            itemCount: filteredPOIs.length,
            itemBuilder: (context, index) {
              var poi = filteredPOIs[index];
              return ListTile(
                title: Row(
                  children: [
                    Checkbox(
                      value: selectedPOIs.contains(poi),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null && value) {
                            selectedPOIs.add(poi);
                          } else {
                            selectedPOIs.remove(poi);
                          }
                        });
                      },
                    ),
                    Text(
                      poi['locations'],
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: selectedPOIs.isNotEmpty
              ? FloatingActionButton(
                  onPressed: () {
                    saveSelectedPOIsToJson(selectedPOIs);
                  },
                  child: Icon(Icons.arrow_forward),
                )
              : null,
        ),
      ),
    );
  }

  void saveSelectedPOIsToJson(List<dynamic> selectedPOIs) {
    // Convert selected POIs to JSON
    final selectedPOIsJson = selectedPOIs.map((poi) => jsonEncode(poi)).toList();

    // Convert the list of JSON strings to a single JSON array string
    final jsonString = '[' + selectedPOIsJson.join(',') + ']';

    // Create a blob containing the JSON data
    final blob = html.Blob([jsonString], 'application/json');

    // Create an object URL for the blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a temporary anchor element to trigger the download
    final anchor = html.AnchorElement(href: url);

    // Set the file name
    anchor.download = 'selected_pois.json';

    // Programmatically click the anchor to trigger the download
    anchor.click();

    // Revoke the object URL to free resources
    html.Url.revokeObjectUrl(url);
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
