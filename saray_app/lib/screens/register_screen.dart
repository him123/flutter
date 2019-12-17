import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:saray_app/components/rounded_buttons.dart';
import 'package:saray_app/constants/constants.dart';
import 'package:saray_app/screens/login_screen.dart';
import 'package:saray_app/screens/shope_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation_dashboard.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSpinner = false;

//  Future<File> imageFile;
  String name, address, email, pass, phone;
  File _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController nameCntrlr = TextEditingController();
  TextEditingController emailCntrlr = TextEditingController();
  TextEditingController addressCntrlr = TextEditingController();
  TextEditingController phoneCntrlr = TextEditingController();
  TextEditingController passwordCntrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Register'),
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _openImagePicker(context);
                    },
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: ClipOval(
                        child: _imageFile != null
                            ? Image.file(
                                _imageFile,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.camera_alt,
                                size: 60.0,
                                color: Theme.of(context).accentColor,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    'Please Select Image',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  controller: nameCntrlr,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    //Do something with the user input.
                    name = value;
                  },
                  decoration:
                      kInputBoxDecoration.copyWith(hintText: 'Enter Name'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: validateEmail,
                  controller: emailCntrlr,
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
                      return 'Please enter address';
                    }
                    return null;
                  },
                  controller: addressCntrlr,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    //Do something with the user input.
                    address = value;
                  },
                  decoration:
                      kInputBoxDecoration.copyWith(hintText: 'Enter Address'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter number';
                    }
                    return null;
                  },
                  controller: phoneCntrlr,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    //Do something with the user input.
                    phone = value;
                  },
                  decoration:
                      kInputBoxDecoration.copyWith(hintText: 'Phone number'),
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
                  controller: passwordCntrlr,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    pass = value;
                  },
                  decoration:
                      kInputBoxDecoration.copyWith(hintText: 'Enter Password'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: RoundedButtons(
                    color: kAccentColor,
                    btnName: 'Sign Up',
                    onPress: () {
                      print(name);
                      print(phone);
//                      if (name == null) {
//                        print('inside the if');
//                        showAlert(context, 'Please enter name');
//                      } else if (email == null) {
//                        showAlert(context, 'Please enter email');
//                      } else if (address == null) {
//                        showAlert(context, 'Please enter address');
//                      } else if (phone == null) {
//                        showAlert(context, 'Please enter phone number');
//                      } else if (pass == null) {
//                        showAlert(context, 'Please enter password');
//                      } else {
//                        print('API WILL CALL');
//                        createPost(context,
//                            '$BASEURL/api/customer.php');
//                      }
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          showSpinner = true;
                        });
                        createPost(context,
                            '$BASEURL/api/customer.php');
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already have an Account?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15.0),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) =>
                                      LoginScreen()));
                        },
                        child: Text(
                          'Login here',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kAccentColor,
                              fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
        _imageFile = image;
      });

      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an Image',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                  child: Text('User Camera'),
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                  child: Text('User Gallery'),
                ),
              ],
            ),
          );
        });
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

  void createPost(BuildContext context, String url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (_imageFile != null) {
      var stream =
          new http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      final length = await _imageFile.length();
      var multiPartImage = http.MultipartFile('profile_image', stream, length,
          filename: basename(_imageFile.path));
      request.files.add(multiPartImage);
    }

    print('====================FILE$_imageFile');
    request.fields['method'] = 'register_customer';
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['password'] = pass;
    request.fields['address'] = address;
    request.fields['phone'] = phone;
    request.fields['fcmtoken'] = 'd4as56f4a56sd4f5a4sd564';

    http.Response response =
        await http.Response.fromStream(await request.send());

    print(response.body);

    String image = json.decode(response.body)['profile_image'];
    int id = json.decode(response.body)['user_id'];
    String nameUser = json.decode(response.body)['name'];
    String tookEmail = json.decode(response.body)['email'];
    String tookAddress = json.decode(response.body)['address'];
    String tookNumber = json.decode(response.body)['phone'];

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('profile_image', image);
    prefs.setString('name', nameUser);
    prefs.setString('id', id.toString());
    prefs.setString('email', tookEmail);
    prefs.setString('address', tookAddress);
    prefs.setString('phone', tookNumber);
    prefs.setString('login', '1');

    print(prefs.getString('profile_image'));

    setState(() {
      showSpinner = false;
    });

//    Navigator.pop(context);
//    Navigator.of(context).pushReplacementNamed(NavigationDashboard.id);

    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (ctxt) => new NavigationDashboard(
            profileImage: image,
            address: address,
            phone: phone,
            email: email,
            name: nameUser,
            custId: id.toString(),
          ),
        ));
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
