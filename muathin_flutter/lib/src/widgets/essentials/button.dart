import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class Button extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final String text;
  final Color color;
  final bool outline;
  final Function onTap;

  Button({this.margin, this.text, this.color, this.outline, this.onTap});

  @override
  Widget build(BuildContext context) {
    double borderWidth = 3.0, fontSize = 18.0;

    return this.outline
        ? Container(
            margin: this.margin,
            height: 65.0,
            child: GestureDetector(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    border: Border.all(width: borderWidth, color: this.color),
                    borderRadius: Config.borderRadius,
                  ),
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
            margin: this.margin,
            height: 60.0,
            child: GestureDetector(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: this.color,
                    border: Border.all(width: borderWidth, color: Colors.transparent),
                    borderRadius: Config.borderRadius,
                  ),
                  child: Center(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            this.text,
                            style: TextStyle(color: Config.bgColor, fontSize: fontSize, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          )))),
              onTap: this.onTap,
            ));
  }
}
