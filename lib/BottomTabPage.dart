import 'package:flutter/material.dart';
import 'package:meets_on_flutter/AccountSettingPage.dart';
import 'package:meets_on_flutter/ChatTabPage.dart';
import 'package:meets_on_flutter/GroupTabPage.dart';
import 'package:meets_on_flutter/SettingTabPage.dart';

class BottomTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPage();
  }
}

class _BottomTabPage extends State<BottomTabPage> {
  int _currentIndex = 0;
  final _pageWidgets = [
    GroupTabPage(),
    ChatTabPage(),
    SettingTabPage(),
    AccountSettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Meets'),
      // ),
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.group),label: 'Group',),
          BottomNavigationBarItem(icon: Icon(Icons.question_answer), label: 'Chats'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
  void _onItemTapped(int index) => setState(() => _currentIndex = index);
}