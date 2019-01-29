import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';
import 'package:muathin/src/pages/welcome.dart';
import 'package:muathin/src/pages/auth/login.dart';
import 'package:muathin/src/pages/auth/register.dart';
import 'package:muathin/src/pages/home/home.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);
    List<Widget> w;

    if (userInheritance.isLoggedIn) {
      w = [
        ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10.0),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text(userInheritance.user.name),
              subtitle: Text('View & Edit Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Change Home Masjid'),
              subtitle: Text(userInheritance.user.mosque.name),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Bookmarks'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Likes'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Notification Prefrences'),
              onTap: () {},
            ),
            SizedBox(height: 25.0),
            userInheritance.user.role == 'user'
                ? ListTile(
                    leading: Icon(Icons.lightbulb_outline),
                    title: Text('Add New Masjid/Organizaiton'),
                    onTap: () {},
                  )
                : Container(),
            userInheritance.user.role == 'user'
                ? ListTile(
                    leading: Icon(Icons.lightbulb_outline),
                    title: Text('Request Mosque Admin Rights'),
                    onTap: () {},
                  )
                : Container(),
            userInheritance.user.role == 'owner'
                ? ListTile(
                    leading: Icon(Icons.lightbulb_outline),
                    title: Text('Switch to Mosque Mode'),
                    onTap: () {
                      Functions.navigateAndReplaceWith(
                          context: context,
                          w: Home(
                            app: 'owner',
                          ));
                    },
                  )
                : Container(),
            userInheritance.user.role == 'admin'
                ? ListTile(
                    leading: Icon(Icons.lightbulb_outline),
                    title: Text('Switch to Admin Mode'),
                    onTap: () {
                      Functions.navigateAndReplaceWith(
                          context: context,
                          w: Home(
                            app: 'admin',
                          ));
                    },
                  )
                : Container(),
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
        ),
      ];
    } else {
      w = [
        ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10.0),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Login'),
              onTap: () {
                Functions.navigateTo(context: context, w: Login(), fullscreenDialog: true);
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text('Register'),
              onTap: () {
                Functions.navigateTo(context: context, w: Register(mosque: userInheritance.mosque), fullscreenDialog: true);
              },
            ),
          ],
        ),
      ];
    }

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
