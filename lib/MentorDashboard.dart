import 'package:flutter/material.dart';

import 'Feed.dart';
import 'Messages.dart';
import 'Profile.dart';

class MentorDashboard extends StatefulWidget{
  MentorDashboardState createState() => MentorDashboardState();
}

class MentorDashboardState extends State<MentorDashboard>{
  int _currentIndex = 0;
  final List<Widget> _children = [
    Feed(isMentee: false,),
    PlaceholderWidget(Colors.white),
    Messages(isMentee: false),
    Profile(isMentee: false,)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.assignment),
            title: new Text('Assignment'),
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

  void onTabTapped(int index) {
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