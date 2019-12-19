import 'package:flutter/material.dart';

//import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
import 'package:provider/provider.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/dummy_data.dart';
import 'package:saray_app/model/material_item.dart';
import 'package:saray_app/model/shop_by_matid.dart';
import 'package:saray_app/providers/cart.dart';
import 'package:saray_app/screens/cart_screen.dart';
import 'package:saray_app/screens/material_details_screen.dart';
import 'package:saray_app/widget/badge.dart';
import 'package:saray_app/widget/shop_item.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SingleItemShop extends StatefulWidget {
  static String id = 'SingleItemShop';
  final String matImg;
  final String matName;
  final String matId;
  final MaterialItem materialItem;

  SingleItemShop({this.matImg, this.matName, this.matId, this.materialItem});

  @override
  _SingleItemShopState createState() => _SingleItemShopState(
      matImg: matImg,
      matName: matName,
      matId: matId,
      materialItem: materialItem);
}

class _SingleItemShopState extends State<SingleItemShop> {
  final items = List<String>.generate(10000, (i) => "Item $i");
  final MaterialItem materialItem;
  final String matImg;
  final String matName;
  final String matId;
  String emptyMessage = '';

  List<ShopByMat> list = List();
  bool showSpinner = false;
  String cartCount = '0';
  String custId;

  _SingleItemShopState(
      {this.matImg, this.matName, this.matId, this.materialItem});

//  @override
//  void onResume() {
//    // TODO: implement onResume
//    super.onResume();
//
//    getCartCount();
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSpinner = true;
    getSuplliersByMaterial(matId);
  }

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
                            builder: (BuildContext context) => CartScreen(
                                  custId: custId,
                                )));
                  },
                ),
              ),
            ],
            title: Text(matName),
          ),
          body: list.isEmpty
              ? Center(
                  child: Text(
                  emptyMessage,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
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
                                builder: (ctxt) => new MaterialDetailScreen(
                                      title: list[index].item_name,
                                      imgUrl: list[index].image,
                                      matName: matName,
                                      shopByMat: ShopByMat(
                                        image: list[index].image,
                                        price: list[index].price,
                                        description: list[index].description,
                                        company: '',
                                        item_id: list[index].item_id,
                                        item_name: matName,
                                        profile: '',
                                        supplier_address:
                                            list[index].supplier_address,
                                        supplier_email:
                                            list[index].supplier_email,
                                        supplier_id: list[index].supplier_id,
                                        supplier_name:
                                            list[index].supplier_name,
                                        supplier_phone:
                                            list[index].supplier_phone,
                                        unit: list[index].unit,
                                      ),
                                    ))).then((val) {
                          print('============back called');
                          getCartCount();
                        });
//            new MaterialPageRoute(
//                builder: (ctxt) => new MaterialDetailScreen(
//                      title: name,
//                      imgUrl: matImg,
//                      matName: matName,
//                    )));
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
                                    list[index].image,
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
//                      name,
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    list[index].item_name,
                                    style: TextStyle(
                                        fontSize: 23.0, fontFamily: 'Sackers'),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    list[index].supplier_address,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Proxinova',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
    );
  }

  Future<String> getSuplliersByMaterial(String id) async {
    print('========= getData called ===========');
    var response = await http
        .get('$BASEURL/api/customer.php?method=item_wise_suppler&item_id=$id');

    this.setState(() {
      dynamic data = json.decode(response.body)['RESULT'];

      if (data != null) {
        if (response.statusCode == 200) {
          list = (data as List)
              .map((data) => new ShopByMat.fromJson(data))
              .toList();

          String firstname = list[0].supplier_name;
          print('All Shops: $firstname');

          setState(() {
            showSpinner = false;
          });
        } else {
          throw Exception('Failed to load photos');
        }
      } else {
        setState(() {
          emptyMessage =
              'No Supplier providing this material as of now, Please check back again later.';
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
