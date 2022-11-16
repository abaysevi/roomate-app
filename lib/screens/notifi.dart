import 'package:flutter/material.dart';
import 'package:roommate_app/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roommate_app/reuse/reusable_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  dynamic room_sta = "";
  dynamic room_id = "";

  Future accept_join() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference Notify =
        FirebaseFirestore.instance.collection("NotifStack");
    await Notify.doc(auth.currentUser?.uid).update({"status": 1});
  }

  @override
  void initState() {
    super.initState();

    currentuserid();
  }

  @override
  Future currentuserid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final CollectionReference notify =
        FirebaseFirestore.instance.collection("NotifStack");
    await notify
        .doc(auth.currentUser?.uid)
        .get()
        .then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        Map<String, dynamic> vlaues = docSnap.data() as Map<String, dynamic>;
        setState(() {
          room_sta = vlaues["status"].toString();
          room_id = vlaues["roomid"].toString();
        });
      }
    });

    return auth.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('NotifStack').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: const Text(
                    'No Data...',
                  ),
                );
              } else {
                print("Yes data Exist");
              }
              return Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 350),
                child: Column(
                  children: [
                    // Text(snapshot.data!.toString()),
                    Text(
                      "Join Request From",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(room_id.toString()),
                    Text(room_sta.toString()),
                    SizedBox(
                      height: 30,
                    ),
                    firebaseUIButton(context, "Accept", () {
                      accept_join();
                    })
                  ],
                ),
              ));
            }),
      );
}
