import 'package:firebase_auth/firebase_auth.dart';
import 'package:roommate_app/reuse/reusable_widget.dart';
import "package:roommate_app/utils/color_utils.dart";
import 'package:flutter/material.dart';
import 'package:roommate_app/screens/basepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _userPlaceTextController = TextEditingController();
  TextEditingController _userage = TextEditingController();
  TextEditingController _userPhoneNum = TextEditingController();

  String gendervalue = "Gender";
  String birthDateInString = "";
  DateTime birthDate = new DateTime.now();
  bool isDateSelected = false;
  String initValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("587F0E"),
            hexStringToColor("02C4C4"),
            hexStringToColor("095B7C")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter Email Id", Icons.email, false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter Phone Number", Icons.phone, false, _userPhoneNum),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Place", Icons.place, false,
                    _userPlaceTextController),
                const SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Date Of Birth",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      onTap: () async {
                        final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.now(),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100));
                        if (datePick != null && datePick != birthDate) {
                          setState(() {
                            birthDate = datePick;
                            isDateSelected = true;

                            // put it here
                            birthDateInString =
                                "${birthDate.month}/${birthDate.day}/${birthDate.year}"; // 08/14/2019
                          });
                        }
                      }),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    isDateSelected
                        ? DateFormat.yMMMd().format(birthDate)
                        : initValue,
                    style: const TextStyle(color: Colors.white),
                  )
                ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton<String>(
                      value: gendervalue,
                      icon: const Icon(Icons.male),
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      dropdownColor: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      // underline: Container(
                      //   height: 2,
                      //   color: Colors.deepPurpleAccent,
                      // ),
                      onChanged: (String? newValue) {
                        setState(() {
                          gendervalue = newValue!;
                          print(gendervalue);
                        });
                      },
                      items: <String>['Gender', 'Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 70,
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                        ),
                        decoration: const InputDecoration(
                          hintText: "Age",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        // maxLength: 2,
                        controller: _userage,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("Created New Account");
                    FirebaseFirestore.instance
                        .collection('UserData')
                        .doc(value.user!.uid)
                        .set({
                      'username': _userNameTextController.text,
                      "email": value.user!.email,
                      "place": _userPlaceTextController.text,
                      "phone": _userPhoneNum.text,
                      "DOB": birthDateInString,
                      "age": _userage.text,
                      "gender": gendervalue
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BasePage()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                })
              ],
            ),
          ))),
    );
  }
}
