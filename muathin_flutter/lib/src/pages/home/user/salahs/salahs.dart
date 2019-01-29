import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/lists/list/salahs_list.dart';
import 'package:muathin/src/widgets/misc/next_salah.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Salahs extends StatefulWidget {
  @override
  _SalahsState createState() => _SalahsState();
}

class _SalahsState extends State<Salahs> {
  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);
    List<Widget> w = [
      Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Config.sColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              userInheritance.mosque.name,
              style: TextStyle(
                color: Config.bgColor,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.location_on, color: Config.bgColor,), onPressed: () {}),
                IconButton(icon: Icon(Icons.computer, color: Config.bgColor), onPressed: () {}),
                IconButton(icon: Icon(Icons.phone, color: Config.bgColor), onPressed: () {}),
                IconButton(icon: Icon(Icons.email, color: Config.bgColor), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
      NextSalah(),
      SalahsList(),
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Prayer Times',
      leading: userInheritance.isLoggedIn
          ? Container()
          : IconButton(
              icon: Icon(Icons.close),
              color: Config.sColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      actions: <Widget>[
        userInheritance.isLoggedIn
            ? IconButton(
                color: Config.sColor,
                icon: ImageIcon(AssetImage(Config.pathGPS)),
                onPressed: () {},
              )
            : Container(),
      ],
      heroTag: 'PrayerTimes',
      androidView: ListView(shrinkWrap: true, children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
