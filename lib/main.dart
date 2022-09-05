import 'package:flutter/material.dart';
import 'package:meets_on_flutter/LoginPage.dart';
import 'BottomTabPage.dart';
import 'SplashPage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

// first commit
// git push test

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meets on Flutter',
      home: LoginPage(),
      // home: SplashPage(),
      // home: BottomTabPage(),
      // routes: <String, WidgetBuilder>{
      //   '/login': (BuildContext context) => LoginPage(),
      //   '/friends': (BuildContext context) => FriendsTabPage(),
      // },
    );
  }
}

