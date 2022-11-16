import 'package:firebase_auth/firebase_auth.dart';
import 'package:roommate_app/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatefulWidget {
  const LogOut({Key? key}) : super(key: key);

  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  Future removedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              removedata();
              print("Signed Out");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
          },
        ),
      ),
    );
  }
}
