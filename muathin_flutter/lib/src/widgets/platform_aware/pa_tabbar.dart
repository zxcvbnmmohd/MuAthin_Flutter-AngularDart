import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class PATabBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Color backgroundColor;
  final List<Widget> views;
  final ValueChanged<int> onTap;

  PATabBar({this.items, this.currentIndex = 0, this.backgroundColor, this.views = const [], this.onTap});

  @override
  _PATabBarState createState() => _PATabBarState();
}

class _PATabBarState extends State<PATabBar> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: widget.items,
              currentIndex: widget.currentIndex,
              backgroundColor: widget.backgroundColor,
              border: Border.all(color: Colors.transparent, width: 0.0, style: BorderStyle.none),
              activeColor: Config.pColor,
              inactiveColor: Config.wColor,
            ),
            tabBuilder: (context, index) {
              return widget.views[index];
            },
            backgroundColor: widget.backgroundColor,
          )
        : Scaffold(
            body: widget.views[widget.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: widget.items,
              onTap: widget.onTap,
              currentIndex: widget.currentIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: Config.sColor,
            ),
            backgroundColor: widget.backgroundColor,
          );
  }
}
