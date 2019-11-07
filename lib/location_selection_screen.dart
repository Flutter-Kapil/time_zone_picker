import 'package:flutter/material.dart';
import 'package:time_zone_picker/main.dart';

class SelectLocation extends StatefulWidget {
  final List locationList;
  SelectLocation(this.locationList);
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

final myController = TextEditingController();

class _SelectLocationState extends State<SelectLocation> {
  @override
  void initState() {
    myController.addListener(() {
      setState(() {});
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: myController,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'Search region (Country/Region)'),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.locationList
              .where((x) => x.contains(myController.text))
              .toList()
              .length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                    (context),
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage(location:widget.locationList
                                .where((x) => x.contains(myController.text))
                                .toList()[index] ,)));
              },
              dense: true,
              title: Center(
                child: Text(widget.locationList
                    .where((x) => x.contains(myController.text))
                    .toList()[index]),
              ),
            );
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    myController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
