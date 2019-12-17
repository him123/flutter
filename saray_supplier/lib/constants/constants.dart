import 'package:flutter/material.dart';

const kBottomContainerHeight = 80.0;
const kActiveCardColor = Color(0xFF1D1E33);
const kInActiveCardColor = Color(0xFF111328);
const kBottomContainerColor = Color(0xFFEB1555);
const kPrimaryColor = Color(0xFFD4AF37);
const kAccentColor = Color(0xFF800000);
const kAccentLightColor = Color(0xFFb73d2a);


const String BASEURL = 'https://adminsaray.000webhostapp.com/';

enum GenderName { male, female }

const kLalbleTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const DashboarTexts = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const otherText = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kNumberTextStyle = TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900);
const kLargeButtonStyle =
    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);
const kTitleTextStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
const kResultTextStyle = TextStyle(
    color: Color(0xFF24D876), fontSize: 22.0, fontWeight: FontWeight.bold);
const kBmiTextStyle = TextStyle(fontSize: 100.0, fontWeight: FontWeight.bold);
const kBodyTextStyle = TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const boxDecorationForDashBoard = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(3.0)),
  color: Colors.deepPurpleAccent,
);



const kInputBoxDecoration= InputDecoration(
  hintText: 'Enter your email',
  hintStyle: TextStyle(fontSize: 15.0),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);


const kInputBoxDecorationProfile= InputDecoration(
  labelText: 'Enter your email',

  hintStyle: TextStyle(fontSize: 15.0),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);

