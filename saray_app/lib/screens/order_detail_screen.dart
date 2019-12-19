import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/model/order_details.dart';
import 'package:saray_app/screens/input_card_details_screen.dart';
import 'package:saray_app/screens/payment_option_screen.dart';
import 'package:saray_app/widget/order_detail_item.dart';

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
  String clientNounce;
  ProgressDialog pr;
  bool isPayament = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isPayament = isPaid;
    finalStatus = status;
    showSpinner = true;
    pr = new ProgressDialog(context);
    getOrderDetailByOrderId(orderId);
    getClientNounce();
  }

  Text setText(String status) {
    if (status == 'Accept') {
      return Text(
        'You have already accepted this order.',
        style: TextStyle(
            fontFamily: 'Proxinova', color: Colors.white, fontSize: 20.0),
      );
    } else if (status == 'Pending') {
      return Text(
        'Supplier donesn\'t respnse this order yet.',
        style: TextStyle(
            fontFamily: 'Proxinova', color: Colors.white, fontSize: 20.0),
      );
    } else {
      return Text(
        'Supplier has rejected this order.',
        style: TextStyle(
            fontFamily: 'Proxinova', color: Colors.white, fontSize: 20.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order no $orderId'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                custName,
                style: TextStyle(
                    fontSize: 23,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return OrderDetailItem(
                      isCart: false,
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
            finalStatus == 'Accept'
                ? isPaidContainer(isPayament)
                : Container(
                    alignment: Alignment.topCenter,
                    color: Theme.of(context).accentColor,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: setText(finalStatus)),
                    ),
                  ),
          ],
        ),
      ),
    );
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
                      'Payment is succefully sent to the supplier for this order.',
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
        color: Theme.of(context).primaryColor,
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
            Center(
              child: FlatButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  'Checkout',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  //************************** OPEN WHEN PAYMENT /////////////////
//                  payNow();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (BuildContext context) =>
                              PaymentOptionScreen(orderId: orderId,)));
                },
              ),
            ),
          ],
        ),
      );
    }
  }

//  payNow() async {
//    print('pay now method');
////    String clientNonce = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpGVXpJMU5pSXNJbXRwWkNJNklqSXdNVGd3TkRJMk1UWXRjMkZ1WkdKdmVDSXNJbWx6Y3lJNklrRjFkR2g1SW4wLmV5SmxlSEFpT2pFMU56WXhOakUyT1Rjc0ltcDBhU0k2SWpsaFlURTJZbVJrTFRsbU9XRXRORE5rTnkwNU5qSXpMVGN4WkRkaE5UQTBNak0zTWlJc0luTjFZaUk2SWpWemJYSmtlbUkwY25sbU5qWnVjek1pTENKcGMzTWlPaUpCZFhSb2VTSXNJbTFsY21Ob1lXNTBJanA3SW5CMVlteHBZMTlwWkNJNklqVnpiWEprZW1JMGNubG1Oalp1Y3pNaUxDSjJaWEpwWm5sZlkyRnlaRjlpZVY5a1pXWmhkV3gwSWpwbVlXeHpaWDBzSW5KcFoyaDBjeUk2V3lKdFlXNWhaMlZmZG1GMWJIUWlYU3dpYjNCMGFXOXVjeUk2ZTMxOS5XSEdSYUJ1MGRoYzYyVDBKZnFwVVZOblFfWkRCSkFhUy1FNmpUZGFHNHA4V0lmZk81TnBZcnEtODRXY3Q2Q2daS25xX2ZfcFhreDZRRGRHTllPZUZqZyIsImNvbmZpZ1VybCI6Imh0dHBzOi8vYXBpLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb206NDQzL21lcmNoYW50cy81c21yZHpiNHJ5ZjY2bnMzL2NsaWVudF9hcGkvdjEvY29uZmlndXJhdGlvbiIsImdyYXBoUUwiOnsidXJsIjoiaHR0cHM6Ly9wYXltZW50cy5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tL2dyYXBocWwiLCJkYXRlIjoiMjAxOC0wNS0wOCJ9LCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94Iiw";
//
//    BraintreePayment braintreePayment = new BraintreePayment();
//    dynamic data = await braintreePayment.showDropIn(
//        nonce: clientNounce,
//        amount: "2.0",
//        enableGooglePay: true,
//        inSandbox: true);
//    print("Response of the payment ${data}");
//    dynamic nounce = json.encode(data);
//    print("Response of the payment ${nounce}");
//
//    String nounceFromServer = json.decode(nounce)['paymentNonce'];
//    print('this is nounce fomr server$nounceFromServer');
//
//    pr.style(
//        message: 'processing payment...',
//        borderRadius: 10.0,
//        backgroundColor: Colors.white,
//        progressWidget: CircularProgressIndicator(),
//        elevation: 10.0,
//        insetAnimCurve: Curves.easeInOut,
//        progress: 0.0,
//        maxProgress: 100.0,
//        progressTextStyle: TextStyle(
//            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//        messageTextStyle: TextStyle(
//            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
//    setState(() {
//      pr.show();
//    });
//
//    sendPaymentNonceToServer(
//        paymentNonce: nounceFromServer,
//        countryCodeAlpha2: 'IN',
//        currency_type: "USD",
//        extendedAddress: 'Ahmedabad',
//        firstname: 'Himanshu',
//        lastname: 'Dhakecha',
//        locality: 'Indian',
//        postalCode: '380015',
//        region: 'India',
//        streeAddress: 'Smarana App');
//  }

  void sendPaymentNonceToServer(
      {String paymentNonce,
      String currency_type,
      String firstname,
      String lastname,
      String streeAddress,
      String extendedAddress,
      String locality,
      String region,
      String postalCode,
      String countryCodeAlpha2}) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$BASEURL/api/checkout.php'));

    request.fields['payment_method_nonce'] = paymentNonce;
    request.fields['amount'] = '1.0';
    request.fields['currency_type'] = currency_type;
    request.fields['firstName'] = firstname;
    request.fields['lastName'] = lastname;
    request.fields['streetAddress'] = streeAddress;
    request.fields['extendedAddress'] = extendedAddress;
    request.fields['locality'] = locality;
    request.fields['region'] = region;
    request.fields['postalCode'] = postalCode;
    request.fields['countryCodeAlpha2'] = countryCodeAlpha2;

    print('Request: ${request.fields.toString()}');

    http.Response response =
        await http.Response.fromStream(await request.send());

    print(response.body);
    int STATUS = json.decode(response.body)['STATUS'];
    String trId = json.decode(response.body)['Result'];

    setState(() {
      if (STATUS == 1) {
        showSpinner = false;
        makePayment(status: STATUS, orderId: orderId, trId: trId);
      } else {
        showSpinner = false;
      }
    });
  }

  void makePayment({
    String trId,
    String orderId,
    int status,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$BASEURL/api/customer.php'));

    request.fields['method'] = 'make_payment';
    request.fields['status'] = status == 1 ? 'Success' : 'Fail';
    request.fields['transaction_id'] = trId;
    request.fields['order_id'] = orderId;

    print('Request: ${request.fields.toString()}');

    http.Response response =
        await http.Response.fromStream(await request.send());

    print(response.body);
    int STATUS = json.decode(response.body)['STATUS'];

    setState(() {
      if (STATUS == 1) {
        showSpinner = false;
        pr.dismiss();

        Alert(
          context: context,
//      type: AlertType.info,
          title: status == 1 ? 'Payment Successfully done' : 'Payment Failed',
//      desc: msg,
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isPayament = true;
                });
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        showSpinner = false;
        pr.dismiss();

        Alert(
          context: context,
//      type: AlertType.info,
          title: 'Something went wrong please, contact your supplier',
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
  }

  Future<String> getOrderDetailByOrderId(String id) async {
    print('========= getData called For Items===========');
    var response = await http.get(
        '$BASEURL/api/supplier.php?method=order_details&order_id=$orderId');

    this.setState(() {
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
                (double.parse(list[i].price));
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

  Future<String> getClientNounce() async {
    print('========= getData called ===========');
    var response =
        await http.get('$BASEURL/api/client_token.php');

    this.setState(() {
      dynamic data = json.decode(response.body)['Token'];

      print('========nuonce: ' + data);
      if (response.statusCode == 200) {
        clientNounce = data;
      } else {
        throw Exception('Failed to load photos');
      }
    });

//    print(data[1]["name"]);

    showSpinner = false;
    return "Success!";
  }
}
