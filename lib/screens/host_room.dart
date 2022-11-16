import 'package:flutter/material.dart';

class HostRoomPage extends StatefulWidget {
  const HostRoomPage({Key? key}) : super(key: key);

  @override
  State<HostRoomPage> createState() => _HostRoomPageState();
}

class _HostRoomPageState extends State<HostRoomPage> {
  Widget appBarTitle = new Text("Search Here.....!");
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: appBarTitle,
          actions: <Widget>[
            IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("Search Here....!");
                  }
                });
              },
            ),
          ]),
    );
  }
}
