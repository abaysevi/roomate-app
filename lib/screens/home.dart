import 'package:flutter/material.dart';
import 'package:roommate_app/screens/setuparoom.dart';
import "search.dart";
import 'package:roommate_app/utils/color_utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 55, 95),
        title: const Text("Home"),
      ),
      // body: const MyStatelessWidget());
      body: Container(
        color: Color.fromARGB(255, 28, 55, 95),
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   hexStringToColor("587F0E"),
        //   hexStringToColor("02C4C4"),
        //   hexStringToColor("095B7C")
        // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: ListView(
          children: <Widget>[
            BuildBasicCard(),
            const SizedBox(
              height: 30,
            ),
            BuildBasicCard3(),
          ],
          scrollDirection: Axis.vertical,
        ),
      ));

  Widget BuildBasicCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: const AssetImage("assets/images/card.jpg"),
              height: 240,
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RoomSetup()),
                  );
                },
              ),
            ),
            const Text(
              "Host A Room",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      );

  Widget BuildBasicCard3() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: const AssetImage("assets/images/card.jpg"),
              height: 240,
              fit: BoxFit.cover,
              child: InkWell(onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              }),
            ),
            const Text(
              "Search A Room",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ],
        ),
      );
}

// class MyStatelessWidget extends StatelessWidget {
