import 'package:flutter/material.dart';
import 'package:saray_app/constants/constants.dart';

import 'navigation_dashboard.dart';

class ContactUs extends StatefulWidget {
  static String id = 'ContactUs';
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: new NavigationDashboard(),    // new Line
      appBar: new AppBar(
        title: new Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'images/logo_name.png',
              height: 180.0,
            ),
            SizedBox(height: 10.0,),
            Text(
              'Contact Info',
              style: TextStyle(fontSize: 27.0, fontFamily: 'Sackers', color: Theme.of(context).accentColor),
            ),
            SizedBox(height: 20.0,),
            Text(
              'Saray Building Materials Trading L.L.C',
              style: TextStyle(fontSize: 19.0, fontFamily: 'Sackers'),
            ),
            SizedBox(height: 10.0,),
            Text(
              'P.O.Box:2098 R.A.K-U.A.E',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Sackers', fontWeight: FontWeight.w200),
            ),
            Text(
              'T:+971 7 226 3888 F:+971 7 226 3880',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Sackers', fontWeight: FontWeight.w200),
            ),
            Text(
              'E:sales@sarayuae.com',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Sackers', fontWeight: FontWeight.w200),
            ),


          ],
        ),
      ),
    );
  }
}
