import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/model/shop_by_matid.dart';
import 'package:saray_app/providers/cart.dart';
import 'package:saray_app/screens/cart_screen.dart';
import 'package:saray_app/screens/order_screen.dart';
import 'package:saray_app/widget/badge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MaterialDetailScreen extends StatefulWidget {
  static String id = 'MaterialDetailScreen';
  final String title;
  final String imgUrl;
  final String matName;
  final ShopByMat shopByMat;

  MaterialDetailScreen({this.title, this.imgUrl, this.matName, this.shopByMat});

  @override
  _MaterialDetailScreenState createState() => _MaterialDetailScreenState(
      title: title, imgUrl: imgUrl, matName: matName, shopByMat: shopByMat);
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {
  final String title;
  final String imgUrl;
  final String matName;
  final ShopByMat shopByMat;
  DateTime selectedDate = DateTime.now();
  int _n = 0;
  String inputterQty='0';
  Cart cart;
  bool showSpinner = false;
  String custId;
  bool isAddedToCart = false;
  String cartCount='0';

  _MaterialDetailScreenState(
      {this.title, this.imgUrl, this.matName, this.shopByMat});

  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cart = Provider.of<Cart>(context, listen: false);

    getCustId();

  }

  void getCustId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    custId = prefs.getString('id');
    print('This is customer id fomr material details $custId');
    getCartCount(custId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => true);
      },
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
          title: Text(matName),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    /*Image*/ Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        child: Image.network(
                          imgUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    /*Price and Unit*/ Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              shopByMat.unit,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Price: ',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.right,
                                ),
                                Icon(
                                  Icons.attach_money,
                                  size: 20.0,
                                ),
                                Text(
                                  shopByMat.price,
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Description*/ Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            child: Text(
                              shopByMat.description,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    /*Supplier*/ Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Sold By',
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  shopByMat.supplier_name,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Sackers',
                                      color: Theme.of(context).accentColor),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  shopByMat.supplier_address,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Proxinova',
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    /*Quantity*/ Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Please input quantity',
                            style: TextStyle(
                                fontSize: 21.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Row(
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    decoration: kInputBoxDecorationQty.copyWith(hintText: 'Input quantity'),
                                    style: Theme.of(context).textTheme.body1,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ], // Only numbers can be
                                    onChanged: (val){
                                      inputterQty = val;
                                      _n = int.parse(inputterQty);
                                    },
                                  ),

                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  shopByMat.unit,
                                  style: TextStyle(
                                      fontSize: 24.0, fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.start,
                                )
                              ],

                            ),
                          ),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              RawMaterialButton(
//                                fillColor: Color(0xFF800000),
//                                elevation: 2.0,
//                                padding: const EdgeInsets.all(6.0),
//                                shape: new CircleBorder(),
//                                onPressed: () {
//                                  add();
//                                },
//                                child: new Icon(
//                                  Icons.add,
//                                  color: Colors.white,
//                                  size: 30.0,
//                                ),
//                              ),
//                              Text('$_n',
//                                  style: new TextStyle(
//                                      fontSize: 30.0,
//                                      fontWeight: FontWeight.bold)),
//                              RawMaterialButton(
//                                fillColor: Color(0xFF800000),
//                                elevation: 2.0,
//                                padding: const EdgeInsets.all(6.0),
//                                shape: new CircleBorder(),
//                                onPressed: () {
//                                  minus();
//                                },
//                                child: new Icon(
//                                    IconData(0xe15b, fontFamily: 'MaterialIcons'),
//                                    size: 30.0,
//                                    color: Colors.white),
//                              ),
//                            ],
//                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    /*Date Time*/ Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Please select delivery date',
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                hoverColor: Color(0xFF800000),
                                onPressed: () {
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2019, 3, 5),
                                      maxTime: DateTime(2025, 6, 7),
                                      theme: DatePickerTheme(
                                        backgroundColor: Color(0xFFffe168),
                                        cancelStyle: TextStyle(
                                            color: Color(0xFF800000),
                                            fontWeight: FontWeight.bold),
                                        doneStyle: TextStyle(
                                            color: Color(0xFF800000),
                                            fontWeight: FontWeight.bold),
                                        itemStyle: TextStyle(
                                            color: Color(0xFF800000),
                                            fontWeight: FontWeight.bold),
                                      ), onChanged: (date) {
                                    print('change $date');
                                  }, onConfirm: (date) {
                                    setState(() {
                                      selectedDate = date;
                                    });
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.en);
                                },
                                child: Container(
                                  alignment: Alignment(0.0, 0.0),
                                  padding:
                                      EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                  decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(5.0)),
                                      color: Color(0xFFffe0b2)),
                                  child: Text(
                                    DateFormat("dd MMM yyyy hh:mm a")
                                        .format(selectedDate)
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              isAddedToCart
                  ? Container(
                color: Color(0xFF800000),
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Succesfully added to the Cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  : GestureDetector(
                onTap: () {
                  if (_n == 0) {
                    Alert(
                      context: context,
//      type: AlertType.info,
                      title: 'Please enter quantity',
//      desc: msg,
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          width: 120,
                        ),
                      ],
                    ).show();
                  } else {
                    // ************** ADD TO CART ******************************
                    if (_n > 0) {
                      setState(() {
                        showSpinner = true;
                      });
                      double totPrice = double.parse(shopByMat.price) * _n;
                      addToCart(
                        del_date: DateFormat("dd MMM yyyy hh:mm a")
                            .format(selectedDate)
                            .toString(),
                          context: context,
                          qty: _n.toString(),
                          unit: shopByMat.unit,
                          price: totPrice.toString(),
                          mat_id: shopByMat.item_id,
                          sup_id: shopByMat.supplier_id,
                          user_id: custId,
                          url:
                          '$BASEURL/api/customer_post.php');
                    } else {
                      Alert(
                        context: context,
//      type: AlertType.info,
                        title: 'Please enter quantity',
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                    }
                  }
                },
                child: Container(
                  color: Color(0xFF800000),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Add to card',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToCart(
      {BuildContext context,
      String url,
      String user_id,
      String mat_id,
      String qty,
      String unit,
      String price,
      String sup_id, String del_date}) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['method'] = 'cart_post';
    request.fields['user_id'] = user_id;
    request.fields['material_id'] = mat_id;
    request.fields['qty'] = qty;
    request.fields['unit'] = unit;
    request.fields['price'] = price;
    request.fields['del_date'] = del_date;
    request.fields['supplier_id'] = sup_id;

    print('Request: ${request.fields.toString()}');


    http.Response response =
        await http.Response.fromStream(await request.send());

    print(response.body);
    int STATUS = json.decode(response.body)['STATUS'];

    setState(() {
      if(STATUS==1) {
        isAddedToCart = true;
        showSpinner = false;
        getCartCount(custId);
      }else{
        showSpinner = false;
        Alert(
          context: context,
//      type: AlertType.info,
          title: 'Cart is filled already for other supplier.',
//      desc: msg,
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    });

//    Navigator.pop(context);
//    Navigator.of(context).pushReplacementNamed(NavigationDashboard.id);
  }

  Future<String> getCartCount(String id) async {
    print('========= getData called ===========');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=cart_order_count&user_id=$id');

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
