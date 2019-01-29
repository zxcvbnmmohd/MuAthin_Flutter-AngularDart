import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';
import 'package:muathin/src/pages/home/home.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/misc/button.dart';
import 'package:muathin/src/widgets/misc/text_view.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailTEC = new TextEditingController();
  TextEditingController _passwordTEC = new TextEditingController();
  FocusNode _emailFN = new FocusNode();
  FocusNode _passwordFN = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);

    List<Widget> w = [
      TextView(
        margin: EdgeInsets.only(top: 25.0),
        padding: EdgeInsets.only(left: 25.0),
        controller: this._emailTEC,
        focusNode: this._emailFN,
        label: 'Email',
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (s) {},
        onSubmitted: (s) {},
        keyboardAppearance: Brightness.light,
      ),
      TextView(
        margin: EdgeInsets.only(top: 0.0),
        padding: EdgeInsets.only(left: 25.0),
        controller: this._passwordTEC,
        focusNode: this._passwordFN,
        label: 'Password',
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.go,
        obscureText: true,
        onChanged: (s) {},
        onSubmitted: (s) {},
        keyboardAppearance: Brightness.dark,
      ),
      Container(
        margin: EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
        child: GestureDetector(
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: Config.sColor,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          onTap: () {},
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 25.0),
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Button(
          outline: false,
          text: 'Login',
          color: Config.sColor,
          height: 65.0,
          onTap: () {
            Services().auth.login(
                email: this._emailTEC.text,
                password: this._passwordTEC.text,
                onSuccess: () async {
                  userInheritance.setIsLoggedIn(true);
                  userInheritance.setUser(await APIs().users.currentUser());
                  Functions.navigateAndReplaceWith(context: context, w: Home(app: 'user'));
                },
                onFailure: (e) {
                  print(e);
                });
          },
        ),
      )
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Login',
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Config.sColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[Container()],
      heroTag: 'Login',
      androidView: ListView(
        children: w,
      ),
      iOSView: SliverList(
        delegate: SliverChildListDelegate(w),
      ),
    );
  }
}
