import 'package:flutter/material.dart';

class RoundedButtons extends StatelessWidget {

  RoundedButtons({this.onPress, this.btnName, this.color});

  final Function onPress;
  final String btnName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(5.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            btnName,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
