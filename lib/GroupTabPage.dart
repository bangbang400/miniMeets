import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:meets_on_flutter/ChatTabPage.dart';

class GroupTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    fetchUserData();

    // getFriendsDocData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Group'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          // stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('FireStore接続エラー');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text('data[user]'),
                  onTap: (){
                    // チャットページに遷移する
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatTabPage(),
                        ),
                    );
                  }
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

fetchUserData() async {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final userId = _firebaseAuth.currentUser?.uid;
  if(userId != null){
    // DocumentSnapshot snapshot = await _fireStore.doc('Users')
  }
}

//　Friendsの配下のデータをリストで取得する
Future<void> getFriendsDocData() async {
  // 現在のユーザ情報を取得する
  final user = FirebaseAuth.instance.currentUser;
  print(user?.uid);
  final friendsCollection = FirebaseFirestore.instance.collection('Users')
      .doc(user?.uid)
      .collection('Friends');
  final querySnapshot = await friendsCollection.get();
  final queryDocSnapshot = querySnapshot.docs;
  for (final snapshot in queryDocSnapshot) {
    final data = snapshot.data();
    print(data);
  }
}