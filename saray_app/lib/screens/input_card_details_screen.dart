import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';

import 'package:saray_app/constants/constants.dart';

class InputCardDetailsScreen extends StatefulWidget {
  static String id = 'InputCardDetailsScreen';
  final String orderId;

  InputCardDetailsScreen({this.orderId});

  @override
  _InputCardDetailsScreenState createState() =>
      _InputCardDetailsScreenState(orderId: orderId);
}

class _InputCardDetailsScreenState extends State<InputCardDetailsScreen> {
  final String orderId;

  _InputCardDetailsScreenState({this.orderId});

  var _formKey = GlobalKey<FormState>();
  final _minimumPadding = 5.0;
  bool showSpinner = false;

  TextEditingController principalController = new TextEditingController();
  TextEditingController termController = new TextEditingController();
  TextEditingController roiController = new TextEditingController();
  bool isPayament = false;
  ProgressDialog pr;
  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/card.png');
    Image image = Image(image: assetImage, width: 160.0, height: 160.0);

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = new ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    children: <Widget>[
                      getImageAsset(),
                      Padding(
                          padding: EdgeInsets.only(
                              top: _minimumPadding, bottom: _minimumPadding),
                          child: TextFormField(
                            style: textStyle,
                            controller: principalController,
                            keyboardType: TextInputType.number,
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Card number';
                              }
                            },
                            decoration: InputDecoration(
                                labelStyle: textStyle,
                                labelText: 'Card number',
                                hintText: 'Card number',
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 15.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              top: _minimumPadding, bottom: _minimumPadding),
                          child: TextFormField(
                            style: textStyle,
                            controller: roiController,
                            keyboardType: TextInputType.text,
                            // ignore: missing_return
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Card holder\'s name';
                              }
                            },
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 15.0),
                                labelStyle: textStyle,
                                labelText: 'Card holder\'s name',
                                hintText: 'Card holder\'s name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              top: _minimumPadding, bottom: _minimumPadding),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextFormField(
                                style: textStyle,
                                keyboardType: TextInputType.datetime,
                                // ignore: missing_return
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Expiry date';
                                  }
                                },
                                controller: termController,
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                        color: Colors.yellowAccent,
                                        fontSize: 15.0),
                                    labelStyle: textStyle,
                                    labelText: 'Expiry date',
                                    hintText: 'Expiry date',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              )),
                              Container(
                                width: _minimumPadding * 5,
                              ),
//                        Expanded(
//                            child: DropdownButton<String>(
//                              items: _currencies.map((String value) {
//                                return DropdownMenuItem<String>(
//                                  value: value,
//                                  child: Text(value),
//                                );
//                              }).toList(),
//                              value: _currentItemSelected,
//                              onChanged: (String value) {
//                                _onDropDownSelected(value);
//                              },
//                            ))
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    showSpinner=true;
                  });
                  pr.style(
                      message: 'processing payment...',
                      borderRadius: 10.0,
                      backgroundColor: Colors.white,
                      progressWidget: CircularProgressIndicator(),
                      elevation: 10.0,
                      insetAnimCurve: Curves.easeInOut,
                      progress: 0.0,
                      maxProgress: 100.0,
                      progressTextStyle: TextStyle(
                          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
                      messageTextStyle: TextStyle(
                          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
                  setState(() {
                    pr.show();
                  });
                  makePayment(
                      orderId: orderId, trId: 'fdffasd878fs', status: 1);
                },
                child: Container(
                  color: Theme.of(context).accentColor,
                  height: 50,
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
                                'Make Payment',
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
                ),
              )
            ],
          ),
        ));
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
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 3);

//                setState(() {
////                  isPayament = true;
//
//                });
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
}
