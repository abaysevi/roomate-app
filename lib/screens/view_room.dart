import 'dart:async';
import "search.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewRoom extends StatefulWidget {
  String roomid;

  ViewRoom({Key? key, required this.roomid}) : super(key: key);

  @override
  State<ViewRoom> createState() => _ViewRoomState();
}

class _ViewRoomState extends State<ViewRoom> {
  dynamic room_name = "";
  dynamic room_price = "";
  dynamic room_addres = "";
  dynamic room_hsotedby = "";
  dynamic room_place = "";
  dynamic room_host_usrid = "";

  @override
  void initState() {
    super.initState();

    fetchroominfo();
  }

  @override
  Future join_room() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference join_data =
        FirebaseFirestore.instance.collection("JoinRoom");
    await join_data.doc(widget.roomid).set({
      "tringtojoin": [
        auth.currentUser?.uid,
        {"status": "requested"},
      ],
    });
    final CollectionReference Notify =
        FirebaseFirestore.instance.collection("NotifStack");
    await Notify.doc(room_host_usrid).set({
      "roomid": widget.roomid,
      "requestedby": auth.currentUser?.uid,
      "status": 0
    });
  }

  @override
  Future fetchroominfo() async {
    final CollectionReference room_Data =
        FirebaseFirestore.instance.collection('RoomData');

    await room_Data.doc(widget.roomid).get().then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        Map<String, dynamic> vlaues = docSnap.data() as Map<String, dynamic>;
        String crrroomplace = vlaues["roomPlace"].toString();
        String crrrroomname = vlaues["roomName"].toString();
        String crrroomprice = vlaues["RoomPrice"].toString();
        String crrroAddr = vlaues["roomAddress"].toString();
        String crrroomhost = vlaues["hostedBy"].toString();
        String crr_rmhosted_id = vlaues["hosted_usrid"].toString();

        // print(vlaues["roomPrice"].toString());
        setState(() {
          room_place = crrroomplace;
          room_hsotedby = crrroomhost;
          room_price = crrroomprice;
          room_name = crrrroomname;
          room_addres = crrroAddr;
          room_host_usrid = crr_rmhosted_id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0)
                  ]),
                ),
                Positioned(
                    top: 50,
                    left: 30,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                room_name,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: Text(
                room_place,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Hosted By " + room_hsotedby),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          room_price.toString() + "/-",
                          style:
                              TextStyle(color: Color.fromARGB(255, 1, 101, 4)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recently booked',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 20,
                              width: 70,
                            ),
                            Positioned(
                                left: 20,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red),
                                )),
                            Positioned(
                                left: 30,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blueAccent),
                                )),
                            Positioned(
                                left: 40,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.yellow),
                                )),
                            Positioned(
                                left: 50,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.green),
                                  child: Center(
                                    child: Text(
                                      '+3',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Text(
                'Free',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.directions_car,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Parking',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.hot_tub,
                            color: Color.fromARGB(255, 177, 150, 0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Bath',
                        style:
                            TextStyle(color: Color.fromARGB(255, 177, 150, 0)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.pool,
                            color: Color.fromARGB(255, 54, 181, 244),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Pool',
                        style:
                            TextStyle(color: Color.fromARGB(255, 54, 181, 244)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.wifi,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'wifi',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 10.0,
                                  spreadRadius: 6)
                            ]),
                        child: Center(
                          child: Icon(
                            Icons.park,
                            color: Color.fromARGB(255, 54, 244, 130),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Park',
                        style:
                            TextStyle(color: Color.fromARGB(255, 54, 244, 130)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 6, 28, 125),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 2.0),
                          )
                        ]),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("Confirmation"),
                                  content: Text("Room booked at " +
                                      room_place.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () => join_room(),
                                      child: Text("ok"),
                                    )
                                  ],
                                )),
                        child: Text(
                          'Join now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
