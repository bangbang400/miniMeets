import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Center(
          child: Row(
            children: [
              const Text('SplashPage!!'),
            ],
          )),
    );
  }
}
