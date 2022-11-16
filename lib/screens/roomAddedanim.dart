import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:roommate_app/reuse/reusable_widget.dart';

class AnimationSuccsus extends StatefulWidget {
  const AnimationSuccsus({Key? key}) : super(key: key);

  @override
  State<AnimationSuccsus> createState() => _AnimationSuccsusState();
}

class _AnimationSuccsusState extends State<AnimationSuccsus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Lottie.asset('assets/anims/102002-success-icon-variation.zip'),
          const SizedBox(height: 60),
          Container(
            alignment: Alignment.center,
            child: const Text("Room Added",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
