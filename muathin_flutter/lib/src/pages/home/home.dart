import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/pages/home/owner/edit_salahs.dart';
import 'package:muathin/src/pages/home/owner/settings/settings.dart';
import 'package:muathin/src/pages/home/owner/archive/archive.dart';
import 'package:muathin/src/pages/home/user/account/account.dart';
import 'package:muathin/src/pages/home/user/feed/feed.dart';
import 'package:muathin/src/pages/home/user/salahs/salahs.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/platform_aware/pa_tabbar.dart';

class Home extends StatefulWidget {
  final String app;

  Home({this.app});

  static const String routeName = '/Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin, RouteAware {
  PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(initialPage: this._currentIndex);

    this._pageController.addListener(() {
      setState(() {
        if (this._currentIndex != this._pageController.initialPage) {
          this._currentIndex = this._pageController.initialPage;
          Services().analytics.notifyAnalyticsOfCurrentScreen('${Home.routeName}/tab${this._currentIndex}');
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Services().analytics.subscribeObserver(routeAware: this, route: ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    this._pageController.dispose();
    Services().analytics.unsubscribeObserver(routeAware: this);
  }

  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);
    List<BottomNavigationBarItem> items = [];
    List<Widget> views = [];

    if (userInheritance.isLoggedIn) {
      if (widget.app == 'user') {
        items = [
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(Config.pathTime)), title: Container(height: 0.0)),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(Config.pathFeed)), title: Container(height: 0.0)),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(Config.pathAccount)), title: Container(height: 0.0)),
        ];
        views = [
          Salahs(),
          Feed(),
          Account(),
        ];
      } else if (widget.app == 'owner') {
        items = [
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(Config.pathTime)), title: Container()),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(Config.pathFeed)), title: Container()),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(Config.pathSettings)), title: Container()),
        ];
        views = [
          EditSalahs(),
          Archive(),
          Settings(),
        ];
      } else if (widget.app == 'admin') {
        items = [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
          BottomNavigationBarItem(icon: Icon(Icons.my_location), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.my_location), title: Container()),
          BottomNavigationBarItem(icon: Icon(Icons.my_location), title: Container()),
        ];
        views = [
          Container(color: Colors.red),
          Container(color: Colors.blue),
          Container(color: Colors.green),
          Container(color: Colors.pink),
        ];
      }
    } else {
      items = [
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(Config.pathTime)), title: Container()),
        BottomNavigationBarItem(icon: ImageIcon(AssetImage(Config.pathAccount)), title: Container()),
      ];
      views = [
        Salahs(),
        Account(),
      ];
    }

    return PATabBar(
      items: items,
      currentIndex: this._currentIndex,
      backgroundColor: Config.bgColor,
      views: views,
      onTap: this._onPageChanged,
    );
  }

  // MARK: - Functions

  _onPageChanged(int i) {
    setState(() {
      this._currentIndex = i;
    });
  }
}
