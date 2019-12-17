import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_app/components/rounded_buttons.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/screens/forget_password_screen.dart';
import 'package:saray_app/screens/navigation_dashboard.dart';
import 'package:saray_app/screens/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:saray_app/screens/shope_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../main.dart';
import 'customer_dashboard.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String email, pass;
  String _status = 'no-action';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (getLoginStatus().toString() == '1') {
      Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => NavigationDashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      height: 300.0,
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
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    obscureText: true,
                      onChanged: (value) {
                        //Do something with the user input.
                        pass = value;
                      },
                    decoration: kInputBoxDecoration.copyWith(
                        hintText: 'Enter Password'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RoundedButtons(
                          color: kAccentLightColor,
                          btnName: 'Login',
                          onPress: () {
//                          Navigator.pushNamed(context, NavigationDashboard.id);
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              setState(() {
                                showSpinner = true;
                              });
                              login(email, pass);
                            }
//
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: RoundedButtons(
                          color: kAccentColor,
                          btnName: 'Sign Up',
                          onPress: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (BuildContext context) =>
                                    ForgetPasswordScreen()));
                      },
                      child: Text(
                        'Forgot Password!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kAccentColor,
                            fontSize: 20.0),
                      ),
                    ),
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

  Future<String> login(String email, String password) async {
    print('========= getData called ===========');
    var response = await http.get(
        '$BASEURL/api/customer.php?method=login&email=$email&password=$password&fcmtocken=123');

    print(response.body);

    if (json.decode(response.body)['STATUS'] == 0) {
      print('fail');
      showAlert(context, json.decode(response.body)['MESSAGE']);
    } else {
      print('success');

      String image = json.decode(response.body)['profile_image'];
      String id = json.decode(response.body)['user_id'];
      String nameUser = json.decode(response.body)['name'];
      String tookEmail = json.decode(response.body)['email'];
      String tookAddress = json.decode(response.body)['address'];
      String tookNumber = json.decode(response.body)['phone'];

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('profile_image', image);
      prefs.setString('name', nameUser);
      prefs.setString('id', id);
      prefs.setString('email', tookEmail);
      prefs.setString('address', tookAddress);
      prefs.setString('phone', tookNumber);
      prefs.setString('login', '1');

      print(prefs.getString('profile_image'));
//      setState(() => this._status = 'loading');
//      appAuth.login().then((result) {
//        if (result) {
//          Navigator.of(context).pushReplacementNamed(NavigationDashboard.id);
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => NavigationDashboard(
                    custId: id,
                    name: nameUser,
                    email: tookEmail,
                    phone: tookNumber,
                    address: tookAddress,
                    profileImage: image,
                  )));
//        } else {
//          setState(() => this._status = 'rejected');
//        }
//      });
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

  Future<String> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('login');
  }
}
