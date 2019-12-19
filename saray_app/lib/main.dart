import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
//import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
//import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
import 'package:provider/provider.dart';
import 'package:saray_app/providers/cart.dart';
import 'package:saray_app/screens/about_us.dart';
import 'package:saray_app/screens/cart_screen.dart';
import 'package:saray_app/screens/contact_us.dart';
import 'package:saray_app/screens/customer_dashboard.dart';
import 'package:saray_app/screens/forget_password_screen.dart';
import 'package:saray_app/screens/order_screen.dart';
import 'package:saray_app/screens/login_screen.dart';
import 'package:saray_app/screens/material_details_screen.dart';
import 'package:saray_app/screens/material_list_screen.dart';
import 'package:saray_app/screens/my_account.dart';
import 'package:saray_app/screens/navigation_dashboard.dart';
import 'package:saray_app/screens/register_screen.dart';
import 'package:saray_app/screens/shope_screen.dart';
import 'package:saray_app/screens/single_item_material.dart';
import 'package:saray_app/screens/single_item_shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

//AuthService appAuth = new AuthService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String login = prefs.getString('login');
  String name = prefs.getString('name');
  String address = prefs.getString('address');
  String phone = prefs.getString('phone');
  String email = prefs.getString('email');
  String image = prefs.getString('profile_image');
  String id = prefs.getString('id');

//  // Set default home.
  Widget _defaultHome;
//
//  // Get result of the login function.
//  bool _result = await appAuth.login();
//  print('login status $_result');

  print('login status $image');

  if (login == '1') {
    _defaultHome = new NavigationDashboard(
      name: name,
      email: email,
      phone: phone,
      address: address,
      profileImage: image,
      custId: id,
    );
  } else {
    _defaultHome = new LoginScreen();
  }



  runApp(
      MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: Cart(),
      ),
    ],
    child: MaterialApp(
//      navigatorObservers: [routeObserver],
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
        NavigationDashboard.id: (context) => NavigationDashboard(
              name: name,
              email: email,
              phone: phone,
              address: address,
              profileImage: image,
              custId: id,
            ),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
        ShopScreen.id: (context) => ShopScreen(),
        MaterialListScreen.id: (context) => MaterialListScreen(),
        AboutUs.id: (context) => AboutUs(),
        ContactUs.id: (context) => ContactUs(),
        Account.id: (context) => Account(),
        OrdersScreen.id: (context) => OrdersScreen(),
        SingleItemShop.id: (context) => SingleItemShop(),
        SingleItemMaterial.id: (context) => SingleItemMaterial(),
        MaterialDetailScreen.id: (context) => MaterialDetailScreen(),
        CartScreen.id: (context) => CartScreen(),
      },
    ),
  ));
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MultiProvider(
//      providers: [
//        ChangeNotifierProvider.value(
//          value: Cart(),
//        ),
//      ],
//      child: MaterialApp(
//        theme: ThemeData(
//          primaryColor: Color(0xFFD4AF37),
//          accentColor: Color(0xFF800000),
//          canvasColor: Color.fromRGBO(255, 254, 229, 1),
//          fontFamily: 'Raleway',
//          textTheme: ThemeData.light().textTheme.copyWith(
//              body1: TextStyle(
//                color: Color.fromRGBO(20, 51, 51, 1),
//              ),
//              body2: TextStyle(
//                color: Color.fromRGBO(20, 51, 51, 1),
//              ),
//              title: TextStyle(
//                fontSize: 20,
//                fontFamily: 'RobotoCondensed',
//                fontWeight: FontWeight.bold,
//              )),
//        ),
//        debugShowCheckedModeBanner: false,
//        initialRoute: LoginScreen.id,
//        home: _defaultHome,
//        routes: {
//          LoginScreen.id: (context) => LoginScreen(),
//          RegisterScreen.id: (context) => RegisterScreen(),
//          NavigationDashboard.id: (context) => NavigationDashboard(),
//          Dashboard.id: (context) => Dashboard(),
//          ShopScreen.id: (context) => ShopScreen(),
//          MaterialListScreen.id: (context) => MaterialListScreen(),
//          AboutUs.id: (context) => AboutUs(),
//          ContactUs.id: (context) => ContactUs(),
//          Account.id: (context) => Account(),
//          OrdersScreen.id: (context) => OrdersScreen(),
//          SingleItemShop.id: (context) => SingleItemShop(),
//          SingleItemMaterial.id: (context) => SingleItemMaterial(),
//          MaterialDetailScreen.id: (context) => MaterialDetailScreen(),
//          CartScreen.id: (context) => CartScreen(),
//        },
//      ),
//    );
//  }
//}
