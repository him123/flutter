import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_app/components/rounded_buttons.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:saray_app/screens/shope_screen.dart';
import 'dart:convert';

import 'material_details_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String id = 'ForgetPasswordScreen';
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String email, pass;
  String _status = 'no-action';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Forget Password'),),
        backgroundColor: Color(0xFFF7F7F7),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      height: 250.0,
                      child: Hero(
                          tag: 'logo',
                          child: Image.asset('images/logo_name.png')),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    validator: validateEmail,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      //Do something with the user input.
                      email = value;
                    },
                    decoration:
                    kInputBoxDecoration.copyWith(hintText: 'Enter Email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RoundedButtons(
                          color: kAccentLightColor,
                          btnName: 'Submit',
                          onPress: () {
//                          Navigator.pushNamed(context, NavigationDashboard.id);
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              setState(() {
                                showSpinner = true;
                              });
//                              login(email, pass);
                            forgetPassword(email);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<String> forgetPassword(String email) async {
    print('========= getData called ===========');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=forget_password_customer&email=$email');

    print(response.body);

    if (json.decode(response.body)['STATUS'] == 0) {
      print('fail');
      showAlert(context, json.decode(response.body)['MESSAGE']);
    } else {
      print('success');
      showAlert(context, json.decode(response.body)['MESSAGE']);
    }

    setState(() {
      showSpinner = false;
    });

    return "Success!";
  }

  void showAlert(BuildContext context, String msg) {
    Alert(
      context: context,
//      type: AlertType.info,
      title: msg,
//      desc: msg,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
}
