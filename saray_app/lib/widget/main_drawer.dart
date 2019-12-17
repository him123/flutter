import 'package:flutter/material.dart';
import 'package:saray_app/screens/about_us.dart';
import 'package:saray_app/screens/contact_us.dart';
import 'package:saray_app/screens/order_screen.dart';
import 'package:saray_app/screens/material_details_screen.dart';
import 'package:saray_app/screens/my_account.dart';
import 'package:saray_app/screens/navigation_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  final String name;
  final String image;
  final String email;
  final String phone;
  final String address;
  final String id;

  MainDrawer(
      {this.name, this.phone, this.email, this.address, this.image, this.id});

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
//    getNameAndImage();

    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(
              name == null ? '' : name,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
            accountEmail: new Text(email == null ? '' : email,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0)),
            decoration: new BoxDecoration(
              color: Color(0xFF800000),
//              image: new DecorationImage(
//                image: new ExactAssetImage('images/logo.jpg'),
//                fit: BoxFit.cover,
//              ),
            ),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(image == null
                    ? 'https://cdn3.iconfinder.com/data/icons/human-resources-management/512/business_man_office_male-512.png'
                    : image)),
          ),
          buildListTile('Home', Icons.home, () {
            Navigator.of(context).pushReplacementNamed(NavigationDashboard.id);
          }),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.black,
              height: 1.0,
            ),
          ),
          buildListTile('My Account', Icons.face, () {
//            Navigator.of(context).pushReplacementNamed(Account.id);
            Navigator.of(context).pop();
            Navigator.of(context).push(
              PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
                return Account(
                  image: image,
                  name: name,
                  email: email,
                  phone: phone,
                  address: address,
                );
              }, transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return new FadeTransition(opacity: animation, child: child);
              }),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.black,
              height: 1.0,
            ),
          ),
          buildListTile('About Us', Icons.info, () {
//            Navigator.of(context).pushReplacementNamed(AboutUs.id);

            Navigator.of(context).pop();
            Navigator.of(context).push(
              PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
                return AboutUs();
              }, transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return new FadeTransition(opacity: animation, child: child);
              }),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.black,
              height: 1.0,
            ),
          ),
          buildListTile('Contact Us', Icons.contacts, () {
//            Navigator.of(context).pushReplacementNamed(ContactUs.id);
            Navigator.of(context).pop();
            Navigator.of(context).push(
              PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
                return ContactUs();
              }, transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return new FadeTransition(opacity: animation, child: child);
              }),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Divider(
              color: Colors.black,
              height: 1.0,
            ),
          ),
          buildListTile('Orders', Icons.reorder, () {
//            Navigator.of(context).pushReplacementNamed(OrdersScreen.id);
            Navigator.of(context).pop();
            Navigator.of(context).push(
              PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
                return OrdersScreen(
                  custId: id,
                );
              }, transitionsBuilder:
                  (_, Animation<double> animation, __, Widget child) {
                return new FadeTransition(opacity: animation, child: child);
              }),
            );
          }),
        ],
      ),
    );
  }
}
