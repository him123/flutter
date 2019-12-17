import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_app/components/rounded_buttons.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation_dashboard.dart';

class Account extends StatefulWidget {
  static String id = 'Account';
  final String name, email, image, address, phone;

  Account({this.name, this.phone, this.email, this.image, this.address});

  @override
  _AccountState createState() =>
      _AccountState(address: address,
          email: email,
          phone: phone,
          name: name,
          image: image
      );
}

class _AccountState extends State<Account> {
  bool showSpinner = false;
  Future<File> imageFile;
  File _imageFile;

  final String name, email, image, address, phone;

  _AccountState({this.name, this.phone, this.email, this.image, this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Alert(
                context: context,
//      type: AlertType.info,
                title: 'Want to Logout?',
//      desc: msg,
                buttons: [
                  DialogButton(
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();

                      prefs.setString('login', '0');
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(LoginScreen.id, (Route<dynamic> route) => false);
                    },
                    width: 120,
                  ),
                  DialogButton(
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  )
                ],
              ).show();
            },
            child: Container(
                margin: EdgeInsets.all(10.0),
                child: Icon(Icons.settings_power)),
          )
        ],
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: Text('My Profile'),
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
//                    _openImagePicker(context);
                  },
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                        image == null
                            ? 'https://cdn3.iconfinder.com/data/icons/human-resources-management/512/business_man_office_male-512.png'
                            : image),
//                    child: ClipOval(
//                      child: _imageFile != null
//                          ? Image.file(
//                        _imageFile,
//                        width: 200,
//                        height: 200,
//                        fit: BoxFit.cover,
//                      )
//                          : Icon(Icons.camera_alt, size: 60.0, color: Theme.of(context).accentColor,),
//                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                enabled: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kInputBoxDecorationProfile.copyWith(
                    labelText: name),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                enabled: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kInputBoxDecorationProfile.copyWith(
                    labelText: email),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                enabled: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kInputBoxDecorationProfile.copyWith(
                    labelText: phone),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                enabled: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: kInputBoxDecorationProfile.copyWith(
                    labelText: address),
              ),
              SizedBox(
                height: 8.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
