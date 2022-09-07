import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  Users(DocumentSnapshot doc){
    user_Name = doc['Users'];
  }
  String user_Name;
}