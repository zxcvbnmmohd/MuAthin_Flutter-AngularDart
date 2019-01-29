import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String title, subtitle;

  EmptyList({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(this.title),
          Text(this.subtitle)
        ],
      ),
    );
  }
}
