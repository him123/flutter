import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_supplier/constants/constants.dart';
import 'package:saray_supplier/model/order_details.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:saray_supplier/model/order.dart';
import 'package:saray_supplier/screens/order_list_screen.dart';
import 'dart:convert';
import 'package:saray_supplier/widget/order_detail_item.dart';

//import 'package:flutter/src/scheduler/priority.dart' as pr;
import 'package:flutter_local_notifications/src/platform_specifics/android/enums.dart'
    as pr;
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailScreen extends StatefulWidget {
  static String id = 'OrderDetailScreen';
  final String orderId;
  final String custName;
  final String status;
  final bool isPayament;

  OrderDetailScreen(
      {this.orderId, this.custName, this.status, this.isPayament});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState(
      orderId: orderId, custName: custName, status: status, isPaid: isPayament);
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final String orderId;
  final String custName;
  final String status;
  final bool isPaid;

//  bool isPayament;

  _OrderDetailScreenState(
      {this.orderId, this.custName, this.status, this.isPaid});

  List<OrderDetials> list = List();
  bool showSpinner = false;
  String emptyMessage = '';
  String totPrice = '0.0';
  String finalStatus;
  String login;
  String supId;
  String supName;
  bool isPayament = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isPayament = isPaid;
    finalStatus = status;
    showSpinner = true;
    getSupplierDetails();
    getOrderDetailByOrderId(orderId);
  }

  getSupplierDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    login = prefs.getString('login');
    supId = prefs.getString('id');
    supName = prefs.getString('name');
  }

  Text setText(String status) {
    if (status == 'Accept') {
      return Text(
        'You have already accepted this order.',
        style: TextStyle(
            fontFamily: 'Proxinova', color: Colors.white, fontSize: 20.0),
      );
    } else {
      return Text(
        'You have reject this order.',
        style: TextStyle(
            fontFamily: 'Proxinova', color: Colors.white, fontSize: 20.0),
      );
    }
  }

  Container isPaidContainer(bool isPayment) {
    if (isPayment) {
      return Container(
        color: Colors.green,
        height: 100,
        alignment: FractionalOffset.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Payment is succefully received for this order.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: Theme.of(context).accentColor,
        height: 60,
        alignment: FractionalOffset.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              'Total Price:',
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontSize: 18,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            Text(
//                              'Time to take:',
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontSize: 18,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ],
//                        ),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              '200',
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontSize: 18,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
            setText(finalStatus),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => true);
      },
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Order no $orderId',
            ),
//            leading: IconButton(
//                icon: new Icon(Icons.arrow_back),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (ctxt) => new
//                      OrderList(name: supName, suppNmae: supName, supiId: supId,)));
//                }),
            centerTitle: true,
          ),
          body: Column(
            children: <Widget>[
              Text(
                'Order From $custName',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return OrderDetailItem(
                        description: list[index].description,
                        image: list[index].image,
                        price: list[index].price,
                        unit: list[index].unit,
                        delivery_date: list[index].delivery_date,
                        item_id: list[index].item_id,
                        item_name: list[index].item_name,
                        qty: list[index].qty,
                        orderId: orderId,
                      );
                    }),
              ),
              finalStatus == 'Pending'
                  ? Container(
                      color: Theme.of(context).accentColor,
                      height: 100,
                      alignment: FractionalOffset.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'Total Price: $totPrice',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                color: kPrimaryColor,
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  acceptOrReject(orderId, 'Accept');
                                },
                              ),
                              FlatButton(
                                color: kPrimaryColor,
                                child: Text(
                                  'Reject',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  acceptOrReject(orderId, 'Reject');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : isPaidContainer(isPayament),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getOrderDetailByOrderId(String id) async {
    print('========= getData called For Items===========');
    var response = await http.get(
        '$BASEURL/api/supplier.php?method=order_details&order_id=$orderId');

    this.setState(() {
      print(response.body);
      dynamic data = json.decode(response.body)['RESULT'];

      if (response.statusCode == 200) {
        if (data != null) {
          list = (data as List)
              .map((data) => new OrderDetials.fromJson(data))
              .toList();

          String firstname = list[0].delivery_date;
          print('All Mat items: $firstname');

          double grandTotPrice = 0.0;
          for (int i = 0; i < list.length; i++) {
            grandTotPrice +=
                (double.parse(list[i].price) * double.parse(list[i].qty));
          }
          print('Toatal may be $grandTotPrice');
          totPrice = grandTotPrice.toString();

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

  Future<String> acceptOrReject(String orderId, String action) async {
    print('========= getData called For Items===========');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=update_order_status&order_id=$orderId&status=$action');

//    this.setState(() {
    dynamic MESSAGE = json.decode(response.body)['MESSAGE'];
    dynamic STATUS = json.decode(response.body)['STATUS'];

    if (response.statusCode == 200) {
      if (STATUS != 0) {
        print('All Mat items: $MESSAGE');
//        Alert(
//          context: context,
//          title: MESSAGE,
//          buttons: [
//            DialogButton(
//              child: Text(
//                "Ok",
//                style: TextStyle(color: Colors.white, fontSize: 20),
//              ),
//              onPressed: () {
//                setState(() {
//                  if (action == 'Accept') {
//                    setState(() {
//                      finalStatus = 'Accept';
//                      Navigator.pop(context);
//                    });
//                  } else if (action == 'Reject') {
//                    setState(() {
//                      finalStatus = 'Reject';
//                      Navigator.pop(context);
//                    });
//                  }
//                });
//              },
//              width: 120,
//            ),
//          ],
//        ).show();

        setState(() {
          if (action == 'Accept') {
              finalStatus = 'Accept';
//              Navigator.pop(context);
          } else if (action == 'Reject') {
              finalStatus = 'Reject';
//              Navigator.pop(context);
          }
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
//    });

//    print(data[1]["name"]);

    showSpinner = false;
    return "Success!";
  }
}
