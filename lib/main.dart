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
  final String location;
  MyHomePage({this.location='Asia/Kolkata'});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List listOfLocations = [];

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    setup();
    timeZoneDatabase.locations.keys.forEach((x) => listOfLocations.add(x));
    // TODO: implement initState
    super.initState();
  }

  Future<void> setup() async {
    await initializeTimeZone();
//    final detroit = getLocation('America/Detroit');
//    final now = new TZDateTime.now(detroit);
  }

  String getTimeZone(String location){
    String sign = TZDateTime.now(getLocation(location)).timeZoneOffset.isNegative?'-':'+';
    int hour = TZDateTime.now(getLocation(location)).timeZoneOffset.inHours;
    int min = TZDateTime.now(getLocation(location)).timeZoneOffset.inMinutes;
    print(min);
    return '$sign'+' '+'$hour'+':'+'${min%60}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select time zone'),
          actions: <Widget>[
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            Icon(Icons.more_vert, color: Colors.white)
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Region'),
                subtitle: Text('${widget.location}  ${getTimeZone(widget.location)}'),
                onTap: () {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) =>
                              SelectLocation(listOfLocations)));
                },
              ),
              FlatButton(
                child: Text('Test Button'),
                onPressed: () {
//              final detroit = getLocation('America/Detroit');
//              print(TZDateTime.now(detroit));
//              print(LocationDatabase().locations.keys);
//              print(timeZoneDatabase.locations.values.runtimeType);
                  print(getTimeZone('Asia/Kolkata'));

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
