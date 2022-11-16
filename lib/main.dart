import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:roommate_app/screens/basepage.dart';
// import 'package:roommate_app/screens/home.dart';

import 'screens/loginpage.dart';
// import 'utils/color_utils.dart';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'et',
        // home: const MyStatefulWidget(),
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: AnimatedSplashScreen(
            duration: 1800,
            splash: "assets/images/logo.png",
            // function: checkIfExist,
            nextScreen: const LoginPage(),
            splashTransition: SplashTransition.fadeTransition,
            // pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.black));
  }
}
