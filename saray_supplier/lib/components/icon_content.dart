import 'package:flutter/material.dart';
import 'package:saray_supplier/constants/constants.dart';


class CardChild extends StatelessWidget {
  final String sex;
  final Icon icon;

  CardChild(this.sex, this.icon);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 5.0,
        ),
        Text(
          sex,
          style: kLalbleTextStyle,
        )
      ],
    );
  }
}
