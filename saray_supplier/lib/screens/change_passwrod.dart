import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_supplier/components/rounded_buttons.dart';
import 'package:saray_supplier/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordScreen extends StatefulWidget {
  static String id = 'ChangePasswordScreen';
  final String supId;
  ChangePasswordScreen({this.supId});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState(supId: supId);
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final String supId;
  _ChangePasswordScreenState({this.supId});
  bool showSpinner = false;
  final _formKey = GlobalKey<FormState>();
  String oldPass, newPass, againNewPass;
  String _status = 'no-action';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Change password'),),
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
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter old password';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      //Do something with the user input.
                      oldPass = value;
                    },
                    decoration: kInputBoxDecoration.copyWith(
                        hintText: 'Enter old Password'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter new password';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      //Do something with the user input.
                      newPass = value;
                    },
                    decoration: kInputBoxDecoration.copyWith(
                        hintText: 'Enter new Password'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter again new password';
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      //Do something with the user input.
                      againNewPass = value;
                    },
                    decoration: kInputBoxDecoration.copyWith(
                        hintText: 'Enter new Password again'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RoundedButtons(
                    color: kAccentLightColor,
                    btnName: 'Submit',
                    onPress: () {
//                          Navigator.pushNamed(context, NavigationDashboard.id);
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        setState(() {
                          showSpinner = true;
                        });
                        changePassword(supId, oldPass, newPass);
                      }
//
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<String> changePassword(String supId, String old_passwrod, String newPassword) async {
    print('========= Change passsword called ===========$supId');
    var response = await http.get(
        '$BASEURL/material/api/supplier.php?method=change_password&new_password=$newPassword&old_password=$old_passwrod&supplier_id=$supId');

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
