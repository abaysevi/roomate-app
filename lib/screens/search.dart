import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'searchservice.dart';
import 'package:get/get.dart';
import 'view_room.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController seach_contro = TextEditingController();
  late QuerySnapshot snapshotData;
  bool is_exicuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchdData() => ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: ((context, int index) {
            return GestureDetector(
              onTap: () {
                String roomidtopass =
                    snapshotData.docs[index]["room_id"].toString();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewRoom(
                              roomid: roomidtopass,
                            )));
              },
              child: ListTile(
                title: Text(
                  snapshotData.docs[index]["roomName"].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
                subtitle: Text(
                  snapshotData.docs[index]["roomPlace"].toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0),
                ),
              ),
            );
          }),
        );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GetBuilder<SearchService>(
            init: SearchService(),
            builder: (val) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextField(
                    onChanged: (value) {
                      String searchterm = seach_contro.text;
                      if (seach_contro.text != "") {
                        searchterm = searchterm[0].toUpperCase() +
                            searchterm.substring(1);
                      }
                      val.queryData(searchterm).then((vall) {
                        snapshotData = vall;
                        setState(() {
                          is_exicuted = true;
                        });
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    controller: seach_contro,
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Colors.white.withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none)),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: is_exicuted
          ? searchdData()
          : Container(
              child: Center(child: Text("Search Here")),
            ),
    );
  }
}
