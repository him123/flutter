import 'package:flutter/material.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/screens/navigation_dashboard.dart';

class AboutUs extends StatefulWidget {
  static String id = 'AboutUs';

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: new NavigationDashboard(),    // new Line
      appBar: new AppBar(
        title: new Text("About Us"),
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
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              style: TextStyle(fontSize: 14.0, fontFamily: 'Sackers', fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }
}
