import 'package:flutter/material.dart';

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

  List subList(List list, String searchParameter) {
    List subList = [];
    for (String x in list) {
//     print(x);
      x.contains(searchParameter) ? subList.add(x) : null;
    }
    print(subList);
    return subList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: myController,
//            onChanged: widget.locationList = subList(),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'Search region (Country/Region)'),
          ),
        ),
        body: ListView.builder(
          itemCount: myController.text.isEmpty
              ? widget.locationList.length
              : subList(widget.locationList, myController.text).length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                print(subList(widget.locationList, myController.text));
              },
              dense: true,
              title: Center(
                child: myController.text.isEmpty
                    ? Text(widget.locationList[index])
                    : Text(
                        subList(widget.locationList, myController.text)[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
