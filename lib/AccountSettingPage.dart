import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meets_on_flutter/SplashPage.dart';

class AccountSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuthをインスタンス化
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      body:Container(
        child: Center(
          child: Row(
            children: [
              // ログアウト
              ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                  if(_auth.currentUser == null){
                    print('ログアウトしました。');
                  }
                  Navigator.push(context, MaterialPageRoute(
                    // スプラッシュ画面に
                      builder: (context) => SplashPage()
                  ));
                },
                child: Text('ログアウト',
                style: TextStyle(
                  color: Colors.red,
                ),),
              ),
              // １つ前に戻る
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text('１つ前に戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}