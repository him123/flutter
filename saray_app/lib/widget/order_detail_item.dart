import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_app/constants/constants.dart';

class OrderDetailItem extends StatefulWidget {
  final String item_id;
  final String qty;
  final String price;
  final String unit;
  final String delivery_date;
  final String item_name;
  final String description;
  final String image;
  final String orderId;
  final bool isCart;

  OrderDetailItem({
    @required this.item_id,
    @required this.qty,
    @required this.price,
    @required this.unit,
    @required this.delivery_date,
    @required this.item_name,
    @required this.description,
    @required this.image,
    @required this.orderId,
    @required this.isCart,
  });

  @override
  _OrderDetailItemState createState() =>
      _OrderDetailItemState(item_id: item_id, isCart: isCart);
}

class _OrderDetailItemState extends State<OrderDetailItem> {
  final String item_id;
  final bool isCart;

  _OrderDetailItemState({this.item_id, this.isCart});

  bool showSpinner = false;

  void selectMeal(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(7.0), topLeft: Radius.circular(7.0)),
          ),
          elevation: 2,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 90.0,
                  width: 120,
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.item_name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Proxinova',
                      ),
                    ),
                    Text(
                      'Quantity: ${widget.qty}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Proxinova',
                      ),
                    ),
                    Text(
                      'Price: ${widget.price}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Proxinova',
                      ),
                    ),
//                    Row(
//                      children: <Widget>[
//                        Container(
//                          width: 190.0,
//                          height: 10.0,
//                        ),
//                        isCart ? IconButton(
//                          icon: Icon(Icons.delete),
//                          onPressed: () {
//
//                            Alert(
//                              context: context,
//                              title: 'Want to remove Material?',
//                              buttons: [
//                                DialogButton(
//                                  child: Text(
//                                    "Yes",
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 20),
//                                  ),
//                                  onPressed: () async {
//                                    setState(() {
//                                      showSpinner = true;
//                                    });
//                                    delFromCart(item_id);
//                                  },
//                                  width: 120,
//                                ),
//                                DialogButton(
//                                  child: Text(
//                                    "No",
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 20),
//                                  ),
//                                  onPressed: () {
//                                    Navigator.pop(context);
//                                    setState(() {
////                                      isCart=true;
//                                    });
//                                  },
//                                  width: 120,
//                                )
//                              ],
//                            ).show();
//                          },
//                        ) : Text(''),
//                      ],
//                    )
//                    Text(description),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> delFromCart(String id) async {
    print('========= Delete item =========== $id');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=delete_cart&cart_id=2&material_id=$id');

    print(response.body);

    this.setState(() {
//      dynamic data = json.decode(response.body)['RESULT'];

      if (response.statusCode == 200) {} else {
        throw Exception('Failed to load photos');
      }
      showSpinner = false;
    });

    return "Success!";
  }
}
