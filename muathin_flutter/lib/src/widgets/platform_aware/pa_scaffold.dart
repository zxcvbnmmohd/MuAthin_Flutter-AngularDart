import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class PAScaffold extends StatefulWidget {
  final bool iOSLargeTitle, iOSMiddle;
  final Color color;
  final String title;
  final Widget leading, androidView, iOSView, middle;
  final List<Widget> actions;
  final String heroTag;

  PAScaffold(
      {this.iOSLargeTitle,
      this.iOSMiddle = false,
      this.color,
      this.title,
      this.leading,
      this.middle,
      this.actions,
      this.heroTag,
      this.androidView,
      this.iOSView});

  @override
  _PAScaffoldState createState() => _PAScaffoldState();
}

class _PAScaffoldState extends State<PAScaffold> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? widget.iOSLargeTitle
            ? Material(
                child: CupertinoPageScaffold(
                  backgroundColor: widget.color,
                  resizeToAvoidBottomInset: false,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      CupertinoSliverNavigationBar(
                        largeTitle: Text(widget.title, style: TextStyle(color: Config.tColor)),
                        leading: widget.leading,
                        middle: widget.iOSMiddle ? widget.middle : null,
                        automaticallyImplyLeading: false,
                        automaticallyImplyTitle: false,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: widget.actions,
                        ),
                        backgroundColor: widget.color,
                        actionsForegroundColor: Config.sColor,
                        border: Border.all(color: Colors.transparent, width: 0.0, style: BorderStyle.none),
                        heroTag: widget.heroTag,
                      ),
                      widget.iOSView,
                    ],
                  ),
                ),
              )
            : Material(
                child: CupertinoPageScaffold(
                  backgroundColor: widget.color,
                  navigationBar: CupertinoNavigationBar(
                    leading: widget.leading,
                    automaticallyImplyLeading: false,
                    automaticallyImplyMiddle: false,
                    middle: Text(widget.title, style: TextStyle(color: Config.tColor)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.actions,
                    ),
                    border: Border.all(color: Colors.transparent, width: 0.0, style: BorderStyle.none),
                    backgroundColor: widget.color,
                    transitionBetweenRoutes: false,
                    heroTag: widget.heroTag,
                  ),
                  child: widget.iOSView,
                ),
              )
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: widget.color,
            appBar: AppBar(
              backgroundColor: widget.color,
              elevation: 0.0,
              leading: widget.leading,
              automaticallyImplyLeading: false,
              title: Text(widget.title, style: TextStyle(color: Config.tColor)),
              actions: widget.actions,
            ),
            body: widget.androidView,
          );
  }
}
