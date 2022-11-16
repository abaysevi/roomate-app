// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, String? title}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic username = "";
  dynamic uerpalce = "";
  dynamic userPhone = "";
  dynamic userDOB = "";
  dynamic userGender = "";
  dynamic usrAge = "";
  // final File _proPic = File("");

  Future uploadPic() async {
    // print("ot");
  }

  @override
  void initState() {
    super.initState();

    fetchPrfileInfo();
  }

  Future fetchPrfileInfo() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final CollectionReference userData =
        FirebaseFirestore.instance.collection('UserData');

    await userData
        .doc(auth.currentUser?.uid)
        .get()
        .then((DocumentSnapshot docSnap) {
      if (docSnap.exists) {
        Map<String, dynamic> vlaues = docSnap.data() as Map<String, dynamic>;
        String crrusername = vlaues["username"].toString();
        String crruerpalce = vlaues["place"].toString();
        String crrphnum = vlaues["phone"];
        String crrDOB = vlaues["DOB"];
        String crrGender = vlaues["gender"];
        String crrage = vlaues["age"];
        // String crr_usr=
        setState(() {
          username = crrusername;
          uerpalce = crruerpalce;
          userPhone = crrphnum;
          userDOB = crrDOB;
          userGender = crrGender;
          usrAge = crrage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile ',
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(
            height: 100,
          ),
          ListTile(
            title: Center(
                child: Text(
              username.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
            subtitle: Center(child: Text(uerpalce.toString())),
          ),
          ListTile(
            title: Text(userGender),
            subtitle: Text(usrAge),
          ),
          ListTile(
            title: Text(userPhone),
            iconColor: Colors.amber,
            subtitle: Text("Date Of Birth " + userDOB),
          ),
          ListTile(
            title: const Text(
              'Social',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                      ),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.instagram),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Social',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                      ),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {}),
                ),
                Expanded(
                  child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.instagram),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
