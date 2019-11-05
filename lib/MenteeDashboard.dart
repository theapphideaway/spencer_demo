import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MenteeDashboard extends StatefulWidget{

  MenteeDashboardState createState() => MenteeDashboardState();
}

class MenteeDashboardState extends State<MenteeDashboard>{
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

  void onTabTapped(int index) async {
    await FirebaseAuth.instance.currentUser().then((user){
      print(user);
    });
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