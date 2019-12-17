import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifecycle_state/flutter_lifecycle_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:saray_supplier/constants/constants.dart';
import 'package:saray_supplier/model/order.dart';
import 'package:saray_supplier/screens/change_passwrod.dart';
import 'package:saray_supplier/screens/forget_password_screen.dart';
import 'dart:convert';

import 'package:saray_supplier/widget/order_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderList extends StatefulWidget {
  static String id = 'OrderList';

  final String supiId;
  final String name;
  final String suppNmae;

  OrderList({this.supiId, this.name, this.suppNmae});

  @override
  _OrderListState createState() =>
      _OrderListState(name: name, supiId: supiId, suppNmae: suppNmae);
}

class _OrderListState extends StateWithLifecycle<OrderList> {
  final String supiId;
  final String name;
  final String suppNmae;

  @override
  void onResume() {
    super.onResume();
    // todo

    print('======onresume ============');

    _onRefresh();
  }

  _OrderListState({this.supiId, this.name, this.suppNmae});

  List<Order> list = List();
  bool showSpinner = false;
  String emptyMessage = '';

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
//    list.clear();
    getOrdersBySupId(supiId);
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    list.clear();
//    getOrdersBySupId(supiId);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSpinner = true;

    print('supplised id $supiId');
    print('supplised name $suppNmae');
    getOrdersBySupId(supiId);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order List'),
          centerTitle: true,
          leading: Text(''),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.lock,
                color: Theme.of(context).accentColor,
              ),
              tooltip: 'Change password',
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(
                                supId: supiId,
                              )));
                });
              },
            )
          ],
          elevation: 12.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome, $suppNmae',
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).accentColor,
                        fontFamily: 'Proxinova',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: list.length > 0
                        ? ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return OrderItem(
                                date: list[index].created_date,
                                id: list[index].order_id,
                                customerName: list[index].customername,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getOrdersBySupId(String id) async {
    print('========= getData called For Items===========');
    var response = await http.get(
        '$BASEURL/api/supplier.php?method=supplier_order_list&supplier_id=$id');

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
          String firstname = list[0].customername;
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
