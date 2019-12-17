import 'package:flutter/material.dart';
import 'package:saray_app/screens/about_us.dart';
import 'package:saray_app/screens/contact_us.dart';
import 'package:saray_app/screens/order_screen.dart';
import 'package:saray_app/screens/home.dart';
import 'package:saray_app/screens/my_account.dart';

class Dashboard extends StatefulWidget {
  static String id = 'dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Account(),
    AboutUs(),
    ContactUs(),
    OrdersScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome'),
        automaticallyImplyLeading: false,
      ),
      body: _children[_currentIndex], // new,

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.face),
            title: new Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('About Us'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            title: Text('Contant Us'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder),
            title: Text('Orders'),
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
