import 'package:flutter/material.dart';
//import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:saray_app/model/order.dart';
import 'package:saray_app/widget/order_item.dart';
import 'navigation_dashboard.dart';

import 'dart:convert';

class OrdersScreen extends StatefulWidget {
  static String id = 'OrdersScreen';
  final String custId;

  OrdersScreen({this.custId});

  @override
  _OrdersScreenState createState() => _OrdersScreenState(custId: custId);
}

class _OrdersScreenState extends State<OrdersScreen> {

  final String custId;

  _OrdersScreenState({this.custId});

  List<Order> list = List();
  bool showSpinner = false;
  String emptyMessage = '';


  @override
//  void onResume() {
//    // TODO: implement onResume
//    super.onResume();
//    getOrdersByCustId(custId);
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSpinner = true;

    getOrdersByCustId(custId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: new NavigationDashboard(),    All Mat items// new Line
      appBar: new AppBar(
        title: new Text("My Orders"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          body: Center(
            child: list.length > 0
                ? ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return OrderItem(
                        date: list[index].created_date,
                        id: list[index].order_id,
                        supplierName: list[index].suppliername,
                        status: list[index].status,
                        totPrice: list[index].total_price,
                        paymentStatus: list[index].payment_status,
                      );
                    })
                : Text(
                    emptyMessage,
                    style: kTitleTextStyle,
                  ),
          ),
        ),
      ),
    );
  }

  Future<String> getOrdersByCustId(String id) async {
    print('========= Order lists ===========$id');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=customer_order_list&user_id=$id');

    print(response.body);

    this.setState(() {
      dynamic data = json.decode(response.body)['RESULT'];
      dynamic status = json.decode(response.body)['STATUS'];
      dynamic MESSAGE = json.decode(response.body)['MESSAGE'];

      if (response.statusCode == 200 && status == 1) {
        if (data != null) {
          list =
              (data as List).map((data) => new Order.fromJson(data)).toList();
          list=list.reversed.toList();

          String firstname = list[0].supplierphone;
          print('All Mat items: $firstname');

          setState(() {
            showSpinner = false;
          });
        } else {
          setState(() {
            emptyMessage = MESSAGE;
            showSpinner = false;
          });
          throw Exception('Failed to load orders');
        }
      } else {
        setState(() {
          emptyMessage = MESSAGE;
          showSpinner = false;
        });
      }
    });

//    print(data[1]["name"]);

    showSpinner = false;
    return "Success!";
  }
}
