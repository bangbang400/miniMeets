import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatelessWidget {
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
                // フォーマットした送信時間
                if(data['last_send_date'] is Timestamp) {
                  DateTime dateTime = data['last_send_date'].toDate();
                  dateStr = dateTime.hour.toString() + ':' + dateTime.minute.toString();
                }
                AlignmentGeometry flg = Alignment.centerLeft;
                // チャットの方向を決める
                if(data['last_send_user_id'] != user?.uid.toString()){
                  flg = Alignment.centerRight;
                }else{
                  flg = Alignment.centerLeft;
                }
                return Align(
                  alignment: flg,
                  child: Container(
                    color: Colors.green,
                    width: 300,
                    height: 70,
                    child: ListTile(
                        leading: Text('アイコン'),
                        title: Text(data['last_send_message']),
                        subtitle: Text(dateStr),
                        onTap: (){}
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
