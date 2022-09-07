import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meets_on_flutter/ChatTabPage.dart';
import 'Users.dart';

class MainModel extends ChangeNotifier {
  List<Users> users = [];

  Future<void>fetchUsers() async {
    final docs = await FirebaseFirestore.instance.collection('Users').get();
    final users = docs.docs.map((doc) => Users(doc)).toList();
    this.users = users;
    notifyListeners();
  }
}