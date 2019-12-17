import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
import 'package:provider/provider.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/providers/cart.dart';
import 'package:saray_app/screens/cart_screen.dart';
import 'package:saray_app/screens/material_list_screen.dart';
import 'package:saray_app/screens/shope_screen.dart';
import 'package:saray_app/widget/badge.dart';
import 'package:saray_app/widget/main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NavigationDashboard extends StatefulWidget {
  static String id = 'NavigationDashboard';
  final String name;
  final String phone;
  final String email;
  final String address;
  final String profileImage;
  final String custId;

  NavigationDashboard(
      {this.name,
      this.phone,
      this.email,
      this.address,
      this.profileImage,
      this.custId});

  @override
  _NavigationDashboardState createState() => _NavigationDashboardState(
      name: name,
      phone: phone,
      email: email,
      address: address,
      profileImage: profileImage,
      id: custId);
}

class _NavigationDashboardState extends StateWithLifecycle<NavigationDashboard> {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String profileImage;
  final String id;
  String cartCount='0';

  _NavigationDashboardState(
      {this.name,
      this.phone,
      this.email,
      this.address,
      this.profileImage,
      this.id});

  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;


  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
    getCartCount();
  }
  @override
  void initState() {


    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    firebaseMessaging.getToken().then((token){
      print(token);

    });
    _pages = [
      {
        'page': ShopScreen(
          title: 'Steel',
        ),
        'title': 'Shops',
      },
      {
        'page': MaterialListScreen(
          title: 'Steel',
        ),
        'title': 'Materials',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, _pages[_selectedPageIndex]['title']),
      drawer: MainDrawer(
        address: address,
        phone: phone,
        email: email,
        name: name,
        image: profileImage,
        id: id,
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.shop),
            title: Text('Shops'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.gavel),
            title: Text('Materials'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            child: ch,
            value: cartCount,
          ),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (BuildContext context) => CartScreen(custId: id,)));
            },
          ),
        ),
      ],
    );
  }

  Future<String> getCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String custId = prefs.getString('id');

    print('========= getData called ===========');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=cart_order_count&user_id=$custId');

    this.setState(() {
      dynamic count = json.decode(response.body)['cart_items'];


      if (response.statusCode == 200) {
        setState(() {
          cartCount = count;
          print('cart count is $cartCount');
        });
      } else {
        throw Exception('Failed to load photos');
      }
    });

    return "Success!";
  }
}
