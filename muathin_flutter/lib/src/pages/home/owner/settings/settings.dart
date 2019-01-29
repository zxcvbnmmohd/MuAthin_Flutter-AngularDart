import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';
import 'package:muathin/src/pages/welcome.dart';
import 'package:muathin/src/pages/home/home.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Settings extends StatefulWidget {
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    List<Widget> w = [
      ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10.0),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Switch to User Mode'),
            onTap: () {
              Functions.navigateAndReplaceWith(
                  context: context, w: Home(app: 'user'));
            },
          ),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Notification Prefrences'),
            onTap: () {},
          ),
          SizedBox(height: 25.0),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Terms of Serivce'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Privacy Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('FAQ'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Contact Us'),
            onTap: () {},
          ),
          SizedBox(height: 25.0),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Remove Ads'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text('Subscription Settings'),
            onTap: () {},
          ),
          SizedBox(height: 25.0),
          ListTile(
            title: Text(
              'Logout',
              textAlign: TextAlign.center,
            ),
            onTap: () {
              Services().auth.logout(onSuccess: () {
                Functions.navigateAndReplaceWith(context: context, w: Welcome());
              }, onFailure: (e) {
                print(e);
              });
            },
          ),
          ListTile(
            title: Text(
              'MuAthin v1.0.0',
              textAlign: TextAlign.center,
            ),
            onTap: () {},
          )
        ],
      )
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Settings',
      leading: Container(),
      actions: <Widget>[Container()],
      heroTag: 'Settings',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
