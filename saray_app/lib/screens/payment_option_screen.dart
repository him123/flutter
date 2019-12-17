import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_app/constants/constants.dart';
import 'input_card_details_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentOptionScreen extends StatefulWidget {
  static String id = 'PaymentOptionScreen';
  final String orderId;

  PaymentOptionScreen({this.orderId});

  @override
  _PaymentOptionScreenState createState() =>
      _PaymentOptionScreenState(orderId: orderId);
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  final String orderId;
  bool showSpinner = false;

  ProgressDialog pr;
  bool isPayament = false;

  @override
  void initState() {
    super.initState();
    pr = new ProgressDialog(context);
  }

  _PaymentOptionScreenState({this.orderId});

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Payment Options'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select your payment method',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)
                    ),
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Cash',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      //************************** OPEN WHEN PAYMENT /////////////////
//                  payNow();
                      setState(() {
                        showSpinner = true;
                      });
                      makePayment(
                          status: 1, trId: 'Cash Payment', orderId: orderId);

//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              fullscreenDialog: true,
//                              builder: (BuildContext context) =>
//                                  InputCardDetailsScreen(orderId: orderId,)));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)
                    ),
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Card',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      //************************** OPEN WHEN PAYMENT /////////////////
//                  payNow();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  InputCardDetailsScreen(
                                    orderId: orderId,
                                  )));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
                Navigator.of(context).popUntil((_) => count++ >= 2);
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
}
