import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';
import 'package:muathin/src/pages/auth/mosques.dart';
import 'package:muathin/src/pages/auth/login.dart';
// import 'package:muathin/src/pages/auth/register.dart';
import 'package:muathin/src/widgets/misc/button.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double btmPadding;

    Platform.isIOS && deviceSize.height >= 812.0 ? btmPadding = 50.0 : btmPadding = 25.0;

    return Material(
      color: Config.bgColor,
      child: Container(
        padding: EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0, bottom: btmPadding),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  Config.pathLogo,
                  height: 200.0,
                  color: Config.pColor,
                ),
                Text(
                  'MuAthin',
                  style: TextStyle(color: Config.pColor, fontSize: 50.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'A Call To Prayer',
                  style: TextStyle(color: Config.pColor, fontSize: 20.0, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Button(
                //   outline: true,
                //   text: 'Register',
                //   color: Config.sColor,
                //   height: 65.0,
                //   onTap: () {
                //     Application.navigateTo(context: context, w: Register(), fullscreenDialog: true);
                //   },
                // ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  outline: false,
                  text: 'Login',
                  color: Config.sColor,
                  height: 65.0,
                  onTap: () {
                    Functions.navigateTo(context: context, w: Login(), fullscreenDialog: true);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Button(
                  outline: true,
                  text: 'Let\'s Begin',
                  color: Config.sColor,
                  height: 65.0,
                  onTap: () {
                    Functions.navigateTo(context: context, w: Mosques(), fullscreenDialog: true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
