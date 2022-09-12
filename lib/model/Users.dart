import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users {

  String user_Name;

  Users(DocumentSnapshot doc){
    user_Name = doc['Users'];
  }

}