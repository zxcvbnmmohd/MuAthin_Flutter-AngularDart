import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final bool outline;
  final double height;
  final Function onTap;

  Button({@required this.outline, @required this.text, @required this.color, @required this.height, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    double radius = 10.0, borderWidth = 3.0, fontSize = 16.0;

    return this.outline
        ? Container(
            height: this.height,
            child: GestureDetector(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      border: Border.all(width: borderWidth, color: this.color)),
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            this.text,
                            style: TextStyle(color: this.color, fontSize: fontSize, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          )))),
              onTap: this.onTap,
            ))
        : Container(
            height: this.height,
            child: GestureDetector(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(radius)),
                      border: Border.all(width: borderWidth, color: Colors.transparent),
                      color: this.color),
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            this.text,
                            style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          )))),
              onTap: this.onTap,
            ));
  }
}
