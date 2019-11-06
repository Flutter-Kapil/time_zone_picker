import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';

void main() => runApp(MyApp());

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

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      ),
    );
  }
}
