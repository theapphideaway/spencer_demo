import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Feed.dart';
import 'Messages.dart';
import 'Profile.dart';


class MenteeDashboard extends StatefulWidget{

  MenteeDashboardState createState() => MenteeDashboardState();
}

class MenteeDashboardState extends State<MenteeDashboard>{
  int _currentIndex = 0;
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');
  final List<Widget> _children = [
    Feed(isMentee: true),
    PlaceholderWidget(Colors.white),
    Messages(isMentee: true),
    Profile(isMentee: true)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
        key: globalKey,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.assignment),
            title: new Text('Checklist'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.chat_bubble),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }

}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}