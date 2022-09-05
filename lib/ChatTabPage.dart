import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meets_on_flutter/ChatDetailPage.dart';

class ChatTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 現在のユーザ情報を取得する
    final user = FirebaseAuth.instance.currentUser;
    final _firestore = FirebaseFirestore.instance;
    // final Stream<QuerySnapshot> _chatsStream = FirebaseFirestore.instance.collection('Users').doc(user?.uid).collection('ChatsTable');
    final Stream<QuerySnapshot> _chatsStream = FirebaseFirestore.instance.collection('Users').doc(user?.uid).collection('ChatsTable').snapshots();

    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('チャット'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _chatsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('接続エラー');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("読み込み中");
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                String dateStr = "";
                //
                if(data['last_send_date'] is Timestamp) {
                  DateTime dateTime = data['last_send_date'].toDate();
                  dateStr = dateTime.hour.toString() + ':' + dateTime.minute.toString();
                }
                return ListTile(
                    leading: Text('アイコン'),
                    title: Text(data['user_Name']),
                    subtitle: Text(data['last_send_message']),
                    trailing: Text(dateStr),
                    onTap: (){
                      // チャットページに遷移する
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetailPage(),
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
