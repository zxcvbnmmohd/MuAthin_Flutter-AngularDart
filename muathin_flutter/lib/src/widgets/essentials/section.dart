import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class Section extends StatelessWidget {
  final String text;

  Section({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        this.text.toUpperCase(),
        style: TextStyle(
          color: Config.tColor,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
