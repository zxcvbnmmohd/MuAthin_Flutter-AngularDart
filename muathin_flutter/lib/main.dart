import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/pages/welcome.dart';
import 'package:muathin/src/pages/home/home.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';

bool _isLoggedIn;
UserModel _cUser;
MosqueModel _cMosque;

Future main() async {
  if ((await Services().auth.auth.currentUser()) != null) {
    _isLoggedIn = true;
    _cUser = await APIs().users.currentUser();
    _cMosque = _cUser.mosque;
  } else {
    _isLoggedIn = false;
  }

  runApp(InheritedUser(
    child: App(),
    isLoggedIn: _isLoggedIn,
    user: _cUser,
    mosque: _cMosque,
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Widget _view = Container();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Services().auth.isLoggedIn(onSuccess: (cUser) {
      setState(() {
        Platform.isIOS
            ? this._view = CupertinoApp(
          home: Home(app: 'user'),
          navigatorObservers: [
            Services().analytics.firebaseAnalyticsObserver
          ],
          title: Config.title,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
        )
            : this._view = MaterialApp(
          home: Home(app: 'user'),
          navigatorObservers: [
            Services().analytics.firebaseAnalyticsObserver
          ],
          title: Config.title,
          debugShowCheckedModeBanner: false,
        );
      });
    }, onFailure: () {
      setState(() {
        Platform.isIOS
            ? this._view = CupertinoApp(
          home: Welcome(),
          navigatorObservers: [
            Services().analytics.firebaseAnalyticsObserver
          ],
          title: Config.title,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
        )
            : this._view = MaterialApp(
          home: Welcome(),
          navigatorObservers: [
            Services().analytics.firebaseAnalyticsObserver
          ],
          title: Config.title,
          debugShowCheckedModeBanner: false,
        );
      });
    });

    return this._view;
  }
}
