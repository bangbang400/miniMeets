import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:meets_on_flutter/ChatTabPage.dart';

class GroupTabPage extends StatelessWidget {

  //final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {

    
    // 現在のユーザ情報を取得する
    final user = FirebaseAuth.instance.currentUser;
    // Firestoreインスタンス
    final _instance = FirebaseFirestore.instance;
    // print("ユーザ情報:user:\n${user}");
    // print("ユーザID:uid:${user?.uid}");
    // print(FirebaseFirestore.instance.collection('Users').doc(uid).collection('Friends').doc().id);

    getFriendsDocData();
    // 友達の名前を検索

    // Friendsリストから１件のuserIDを取得する
    // for i in Friendsの中身 {
    //     if (where(i)){
    //           // user発見
    //           // userNameをリストに保存する
    //     }
    // }
    // list ・・・友達の名前リストを表示する

    final store = _instance.collection('Users').where('name', isEqualTo: '山田太郎').get();
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Users').doc(user?.uid).collection('Friends').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('友達'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
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

// Future (単体の非同期データを扱う場合）
// Stream (複数の非同期データを扱う場合）
// Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDocId() async {
//   // 現在のユーザ情報を取得する
//   final user = FirebaseAuth.instance.currentUser;
//   print("ユーザ情報:user:\n${user}");
//   print("ユーザID:uid:${user?.uid}");
//   // print(FirebaseFirestore.instance.collection('Users').doc(uid).collection('Friends').doc().id);
//   List<DocumentSnapshot> docList = [];
//   final snapshot = await FirebaseFirestore.instance.collection('Users').doc(user?.uid).collection('Friends').get();
//   //友達リストを表示する
//   return snapshot.docs;
// }

// ↓memo↓
// child: Text("Friends",style: TextStyle(fontSize: 20),),
//

//　Friendsの配下のデータをリストで取得する
Future<void> getFriendsDocData() async {
  // 現在のユーザ情報を取得する
  final user = FirebaseAuth.instance.currentUser;
  print(user?.uid);
  final friendsCollection = FirebaseFirestore.instance.collection('Users')
      .doc(user?.uid)
      .collection('Friends');
  final querySnapshot = await friendsCollection.get();
  // print(querySnapshot);
  final queryDocSnapshot = querySnapshot.docs;
  // print(queryDocSnapshot);
  for (final snapshot in queryDocSnapshot) {
    final data = snapshot.data();
    print(data);
  }
}