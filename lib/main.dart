import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:time_zone_picker/location_selection_screen.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter/services.dart';
import 'package:timezone/standalone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var byteData =
      await rootBundle.load('packages/timezone/data/$tzDataDefaultFilename');
  initializeDatabase(byteData.buffer.asUint8List());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String location;
  MyHomePage({this.location = 'Asia/Kolkata'});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List listOfLocations = [];

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    setup();
    //converting Map keys from database into list
    timeZoneDatabase.locations.keys.forEach((x) => listOfLocations.add(x));
    // TODO: implement initState
    super.initState();
  }

  Future<void> setup() async {
    await initializeTimeZone();
//    final detroit = getLocation('America/Detroit');
//    final now = new TZDateTime.now(detroit);
  }

  String getTimeZone(String location) {
    String sign =
        TZDateTime.now(getLocation(location)).timeZoneOffset.isNegative
            ? '-'
            : '+';
    int hour =
        TZDateTime.now(getLocation(location)).timeZoneOffset.inHours.abs();
    int min = TZDateTime.now(getLocation(location)).timeZoneOffset.inMinutes;
    print(min);
    return '$sign' + ' ' + '$hour' + ':' + '${min % 60}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          title: Text('Select time zone'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: () async {
                    dynamic newLocation = await showSearch(
                      context: context,
                      delegate: LocationsSearch(listOfLocations),
                    );
                    print('newLocation is $newLocation');
                    if (newLocation != null) {
                      widget.location = newLocation;
                      setState(() {});
                    }
                  },
                  icon: Icon(Icons.search, color: Colors.white)),
            ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Region'),
                subtitle:
                    Text('${widget.location}  ${getTimeZone(widget.location)}'),
                onTap: () {
//                  Navigator.push(
//                      (context),
//                      MaterialPageRoute(
//                          builder: (context) =>
//                              SelectLocation(listOfLocations)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationsSearch extends SearchDelegate<String> {
  final List<dynamic> cities;

  LocationsSearch(this.cities);

  @override
  List<Widget> buildActions(BuildContext context) {
//    can display multiple icons on the top right corner
    //like close button,
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // to close or back arrow on the top left
    //for now returning null
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List results =
        listOfLocations.where((cityName) => cityName.contains(query)).toList();
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List results = listOfLocations
        .where((cityName) => cityName.toLowerCase().contains(query))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            close(context, results[index]);
//            query = results[index];
//            Navigator.push(
//                (context),
//                MaterialPageRoute(
//                    builder: (context) => MyHomePage(
//                          location: listOfLocations[index],
//                        )));
          },
          dense: true,
          title: Text(results[index]),
        );
      },
    );
  }
}
