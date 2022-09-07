import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meets_on_flutter/ChatTabPage.dart';
import 'package:meets_on_flutter/model/main_model.dart';
import 'package:provider/provider.dart';

class GroupTabPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..fetchUsers(),

      ),
    )
  }
}
