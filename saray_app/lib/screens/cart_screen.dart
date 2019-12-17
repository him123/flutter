import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/model/cart.dart';
import 'package:saray_app/widget/cart_item.dart' as ci;
import 'package:http/http.dart' as http;
import 'package:saray_app/widget/order_detail_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saray_app/providers/cart.dart' as cart;

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';
  final String supId;
  final String custId;

  CartScreen({this.supId, this.custId});

  @override
  _CartScreenState createState() => _CartScreenState(custId: custId);
}

class _CartScreenState extends State<CartScreen> {
  final String custId;
  List<cart.CartItem> cartList;

  _CartScreenState({this.custId});

  String totPrice = '0.0';
  bool showSpinner = false;
  bool isOrdered = false;
  List<Cart> list = List();
  String sup_id;
  String cart_id;
  String emptyMsg='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    showSpinner = true;

    getCartList(custId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: list.length > 0
                    ? ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return OrderDetailItem(
                            isCart: true,
                            item_id: list[index].material_id,
                            item_name: list[index].item_name,
                            price: list[index].price,
                            unit: list[index].unit,
                            image: list[index].image,
                            description: list[index].description,
                            delivery_date: list[index].del_date,
                            qty: list[index].qty,
                          );
                        })
                    : Text(
                        emptyMsg,
                        style: TextStyle(fontSize: 24.0),
                      ),
              ),
            ),
            list.length > 0 ? getContainer(isOrdered) : Container(),
          ],
        ),
      ),
    );
  }

  Container getContainer(bool isOrdered) {
    if (isOrdered) {
      return Container(
        color: kAccentLightColor,
        height: 100,
        alignment: FractionalOffset.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Center(
                child: Text(
                  'Total Price: $totPrice',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Text(
                'Order send successfully.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: kAccentLightColor,
        height: 100,
        alignment: FractionalOffset.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Center(
                child: Text(
                  'Total Price: $totPrice',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: FlatButton(
                color: kPrimaryColor,
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  showSpinner = true;
                  double tot = 0.0;

                  for (int i = 0; i < list.length; i++) {
                    tot += double.parse(list[i].price);
                    print('tot ${tot}');
                  }
//                              cart.CartItem cartItem = cart.CartItem(
//                                price: totPrice,
//                                unit:
//                              );
                  List jsonList =
                      cart.CartItem.encondeToJson(cartList.toList());
//
                  var body = json.encode({
                    "supplier_id": sup_id,
                    "cart_id": cart_id,
                    "customer_id": widget.custId,
                    "total_price": tot,
                    "currency": 'BHD',
                    "data": jsonList
                  });
//
                  print("body: ${body}");
//
                  setState(() {
                    showSpinner = true;
                  });
                  createOrder(
                      context,
                      '$BASEURL/api/customer_post.php',
                      body);
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  void createOrder(BuildContext context, String url, var body) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['method'] = 'order_post';
    request.fields['data'] = body;

    http.Response response =
        await http.Response.fromStream(await request.send());

    print(response.body);
    dynamic STATUS = json.decode(response.body)['STATUS'];

    if (STATUS == 1) {
      setState(() {
        showSpinner = false;
        isOrdered = true;
      });
    } else {
      setState(() {
        showSpinner = false;
      });
    }
//    Navigator.pop(context);
//    Navigator.of(context).pushReplacementNamed(NavigationDashboard.id);

//    Navigator.push(
//        context,
//        new MaterialPageRoute(
//          builder: (ctxt) => new NavigationDashboard(
//            profileImage: image,
//            address: address,
//            phone: phone,
//            email: email,
//            name: nameUser,
//          ),
//        ));
  }

  Future<String> getCartList(String id) async {
    print('========= get CART LIST called ===========');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=cart_order_list&user_id=$id');

    print(response.body);

    this.setState(() {
      sup_id = json.decode(response.body)['supplier_id'];
      cart_id = json.decode(response.body)['cart_id'];
      int STATUS = json.decode(response.body)['STATUS'];
      dynamic data = json.decode(response.body)['RESULT'];

      cart.CartItem cartItem;
      if (STATUS == 1) {
        list = (data as List).map((data) => new Cart.fromJson(data)).toList();

        double grandTotPrice = 0.0;

        cartList = List<cart.CartItem>();

        for (int i = 0; i < list.length; i++) {
          cartItem = cart.CartItem(
            price: double.parse(list[i].price),
            unit: list[i].unit,
            date: list[i].del_date,
            matid: list[i].material_id,
            quantity: int.parse(list[i].qty),
          );
          cartList.add(cartItem);

          grandTotPrice += double.parse(list[i].price);
        }
        totPrice = grandTotPrice.toString();
        print('Toatal may be $grandTotPrice');

        setState(() {
          showSpinner = false;
        });
      } else {
        setState(() {
          emptyMsg = 'Cart is empty.';
          showSpinner = false;
        });
        throw Exception('Failed to load photos');
      }
    });

//    print(data[1]["name"]);

    showSpinner = false;
    return "Success!";
  }
}
