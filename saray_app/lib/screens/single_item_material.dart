import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/dummy_data.dart';
import 'package:saray_app/model/material_item.dart';
import 'package:saray_app/model/shop.dart';
import 'package:saray_app/providers/cart.dart';
import 'package:saray_app/screens/cart_screen.dart';
import 'package:saray_app/widget/badge.dart';
import 'package:saray_app/widget/mat_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SingleItemMaterial extends StatefulWidget {
  static String id = 'SingleItemMaterial';
  final String shopName;
  final String shopId;
  final Shop shop;

  SingleItemMaterial({this.shopName, this.shopId, this.shop});

  @override
  _SingleItemMaterialState createState() =>
      _SingleItemMaterialState(shopName: shopName, shopId: shopId, shop: shop);
}

class _SingleItemMaterialState extends StateWithLifecycle<SingleItemMaterial> {
  final String shopName;
  final String shopId;
  final Shop shop;
  String emptyMessage = '';
  String cartCount='0';

  List<MaterialItem> list = List();
  bool showSpinner = false;
  String custId='0';

  _SingleItemMaterialState({this.shopName, this.shopId, this.shop});


  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();

    print('=======On Resume ==========');
    getCartCount();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSpinner = true;
    getMaterialsByShopId(shopId);
//    getCartCount();

  }

//  void getCustId() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//
//    String custId = prefs.getString('id');
//    print('This is customer id fomr material details $custId');
//    getCartCount();
//  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(
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
                            builder: (BuildContext context) => CartScreen(custId: custId,)));
                  },
                ),
              ),
            ],
            title: Text(shopName),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: list.isEmpty
                ? Center(child: Text(emptyMessage, style: TextStyle(color: Theme
                .of(context)
                .accentColor, fontSize: 20.0, fontFamily: 'Proxinova'),))
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return MatItem(
                        title: list[index].title,
                        description: list[index].description,
                        id: list[index].id,
                        imageUrl: list[index].imgUrl,
                        shopName: shop.name,
                        price: list[index].price,
                        address: shop.address,
                        email: shop.email,
                        phone: shop.phone,
                        sid: shop.id,
                        unit: list[index].unit,
                      );
                    }),
          )),
    );
  }

  Future<String> getMaterialsByShopId(String id) async {
    print('========= getData called For Items===========');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=suppler_item&supplier_id=$id');

    this.setState(() {
      dynamic data = json.decode(response.body)['RESULT'];

      if (response.statusCode == 200) {
        if (data != null) {
          list = (data as List)
              .map((data) => new MaterialItem.fromJson(data))
              .toList();

          String firstname = list[0].title;
          print('All Mat items: $firstname');

          setState(() {
            showSpinner = false;
          });
        } else {
          setState(() {
            emptyMessage = 'This supplier doesn\'t providing any material as of now, Please check after sometime.';
            showSpinner = false;
          });
          throw Exception('Failed to load photos');
        }
      } else {
        setState(() {
          showSpinner = false;
        });
      }
    });

//    print(data[1]["name"]);

    showSpinner = false;
    return "Success!";
  }

  Future<String> getCartCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    custId = prefs.getString('id');

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
