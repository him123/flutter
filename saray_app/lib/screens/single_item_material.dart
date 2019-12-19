import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/dummy_data.dart';
import 'package:saray_app/model/material_item.dart';
import 'package:saray_app/model/shop.dart';
import 'package:saray_app/model/shop_by_matid.dart';
import 'package:saray_app/providers/cart.dart';
import 'package:saray_app/screens/cart_screen.dart';
import 'package:saray_app/screens/material_details_screen.dart';
import 'package:saray_app/widget/badge.dart';
import 'package:http/http.dart' as http;
import 'package:saray_app/widget/mat_item.dart';
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

class _SingleItemMaterialState extends State<SingleItemMaterial>
    with WidgetsBindingObserver {
  final String shopName;
  final String shopId;
  final Shop shop;
  String emptyMessage = '';
  String cartCount = '0';

  List<MaterialItem> list = List();
  bool showSpinner = false;
  String custId = '0';

  _SingleItemMaterialState({this.shopName, this.shopId, this.shop});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
//    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print('==========On resume calle ===============');
    } else if (state == AppLifecycleState.inactive) {
      print('==========inactive calle ===============');
    } else if (state == AppLifecycleState.paused) {
      print('==========paused calle ===============');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    showSpinner = true;
    getMaterialsByShopId(shopId);
    getCartCount();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
                builder: (_, cart, ch) =>
                    Badge(
                      child: ch,
                      value: cartCount,
                    ),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    print(custId);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) =>
                                CartScreen(
                                  custId: custId,
                                )));
                  },
                ),
              ),
            ],
            title: Text(shopName),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: list.isEmpty
                ? Center(
                child: Text(
                  emptyMessage,
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .accentColor,
                      fontSize: 20.0,
                      fontFamily: 'Proxinova'),
                ))
                : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (ctxt) =>
                              new MaterialDetailScreen(
                                title: shopName,
                                imgUrl: list[index].imgUrl,
                                matName: list[index].title,
                                shopByMat: ShopByMat(
                                  image: list[index].imgUrl,
                                  price: list[index].price,
                                  description: list[index].description,
                                  company: '',
                                  item_id: list[index].id,
                                  item_name: list[index].title,
                                  profile: '',
                                  supplier_address: shop.address,
                                  supplier_email: shop.email,
                                  supplier_id: shop.id,
                                  supplier_name: shop.name,
                                  supplier_phone: shop.phone,
                                  unit: list[index].unit,
                                ),
                              ))).then(
                              (val) {
                            print('============back called');
                            getCartCount();
                          });
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(7.0),
                            topLeft: Radius.circular(7.0)),
                      ),
                      elevation: 4,
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    topLeft: Radius.circular(7.0)),
                                child: Image.network(
                                  list[index].imgUrl,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
//                Positioned(
//                  child: Container(
//                    width: 200,
//                    color: Colors.black54,
//                    padding: EdgeInsets.symmetric(
//                      vertical: 10,
//                      horizontal: 30,
//                    ),
//                    child: Text(
//                      title,
//                      style: TextStyle(
//                          fontSize: 16,
//                          color: Colors.white,
//                          fontWeight: FontWeight.bold),
//                      softWrap: true,
//                      overflow: TextOverflow.fade,
//                    ),
//                  ),
//                )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(7),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  list[index].title,
                                  style: TextStyle(
                                      fontSize: 23.0,
                                      fontFamily: 'Sackers'),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Price',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      list[index].price,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Center(
                                        child: Text(
                                          'BHD',
                                          style: TextStyle(fontSize: 16.0),
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Center(
                                      child: Text(
                                        'per',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      list[index].unit,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )),
    );
  }

  Future<String> getMaterialsByShopId(String id) async {
    print('========= getData called For Items===========');
    var response = await http
        .get('$BASEURL/api/customer.php?method=suppler_item&supplier_id=$id');

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
            emptyMessage =
            'This supplier doesn\'t providing any material as of now, Please check after sometime.';
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
    print('========= Cart Refreshed ===========');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    custId = prefs.getString('id');


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
