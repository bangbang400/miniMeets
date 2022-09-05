import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AccountSettingPage.dart';

class SettingTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FirebaseAuthをインスタンス化
    final user = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: Container(
        child: SeparatedList(),
      ),
    );
  }

  // 区切り線ありのリスト
  Widget SeparatedList() {
    final setting_list = ["アカウント設定"];// 設定リスト
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // １件のアイテムについて
          return settingItem(context,setting_list, index);
        },
        separatorBuilder: (context, index) {
          // リストのセパレータについて
          return separatorItem();
        },
        itemCount: setting_list.length,
    );
  }

  //　区切りのスタイル
  Widget separatorItem() {
    return Container(
      // height: 20,
      // color: Colors.orange,
    );
  }

  //
  Widget settingItem(context, list, index) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border(
            bottom: BorderSide(
                width:  1.0,
                color: Colors.grey,
            ),
        ),
      ),
      child: ListTile(
        title: Text(
          list[index],
          style: TextStyle(
              fontSize: 18.0,
              // fontWeight: FontWeight.bold
          ),
        ),
        onTap: () {
          switch (index) {
            case 0:
              // アカウント設定
              print("アカウント設定がタップされました");
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingPage()));
              break;
            default:
              print("switchの引数にない値");
              break;
          }

        },
      ),
    );
  }
}
