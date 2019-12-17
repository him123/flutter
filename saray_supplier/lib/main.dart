import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
import 'package:provider/provider.dart';
import 'package:saray_supplier/screens/change_passwrod.dart';
import 'package:saray_supplier/screens/forget_password_screen.dart';
import 'package:saray_supplier/screens/login_screen.dart';
import 'package:saray_supplier/screens/order_detail.dart';
import 'package:saray_supplier/screens/order_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String login = prefs.getString('login');
  String supId = prefs.getString('id');
  String supName = prefs.getString('name');

  //  // Set default home.
  Widget _defaultHome;




//
//  // Get result of the login function.
//  bool _result = await appAuth.login();
//  print('login status $_result');

  if (login == '1') {
    _defaultHome = OrderList(
      name: supName,
      supiId: supId,
      suppNmae: supName,
    );
  } else {
    _defaultHome = new LoginScreen();
  }

  runApp(MaterialApp(
    navigatorObservers: [routeObserver],
    theme: ThemeData(
      primaryColor: Color(0xFFD4AF37),
      accentColor: Color(0xFF800000),
      canvasColor: Color.fromRGBO(255, 254, 229, 1),
      fontFamily: 'Raleway',
      textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )),
    ),
    debugShowCheckedModeBanner: false,
    // initialRoute: LoginScreen.id,
    home: _defaultHome,
    routes: {
      LoginScreen.id: (context) => LoginScreen(),
      OrderList.id: (context) => OrderList(
            name: supName,
            supiId: supId,
          ),
      OrderDetailScreen.id: (context) => OrderDetailScreen(),
      ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
      ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
    },
  ));
}
