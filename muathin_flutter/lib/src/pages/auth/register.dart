import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';
import 'package:muathin/src/pages/home/home.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/misc/button.dart';
import 'package:muathin/src/widgets/misc/text_view.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Register extends StatefulWidget {
  final MosqueModel mosque;

  Register({this.mosque});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _firstNameTEC = new TextEditingController();
  TextEditingController _lastNameTEC = new TextEditingController();
  TextEditingController _emailTEC = new TextEditingController();
  TextEditingController _passwordTEC = new TextEditingController();
  FocusNode _firstNameFN = new FocusNode();
  FocusNode _lastNameFN = new FocusNode();
  FocusNode _emailFN = new FocusNode();
  FocusNode _passwordFN = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final userState = InheritedUser.of(context);

    List<Widget> w = [
      Row(
        children: <Widget>[
          Expanded(
              child: TextView(
            margin: EdgeInsets.only(top: 25.0),
            padding: EdgeInsets.only(left: 25.0),
            controller: this._firstNameTEC,
            focusNode: this._firstNameFN,
            label: 'Firstname',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            autoFocus: true,
            onChanged: (s) {},
            onSubmitted: (s) {},
            keyboardAppearance: Brightness.light,
          )),
          Expanded(
              child: TextView(
            margin: EdgeInsets.only(top: 25.0),
            padding: EdgeInsets.only(left: 0.0),
            controller: this._lastNameTEC,
            focusNode: this._lastNameFN,
            label: 'Lastname',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (s) {},
            onSubmitted: (s) {},
            keyboardAppearance: Brightness.light,
          ))
        ],
      ),
      TextView(
        margin: EdgeInsets.only(top: 0.0),
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
        margin: EdgeInsets.only(top: 25.0),
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Button(
          outline: false,
          text: 'Register',
          color: Config.sColor,
          height: 65.0,
          onTap: () {
            Map<String, dynamic> m = {
              'name': this._firstNameTEC.text + ' ' + this._lastNameTEC.text,
              'email': this._emailTEC.text,
              'role': 'user',
              'homeMosque': APIs().mosques.mosquesCollection.document(widget.mosque.mosqueID),
              'createdAt': DateTime.now()
            };

            Services().auth.register(
                m: m,
                password: this._passwordTEC.text,
                onSuccess: (u) {
                  APIs().users.currentUser().then((user) {
                    userState.setIsLoggedIn(true);
                    userState.setUser(user);
                  });
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
      title: 'Register',
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
      heroTag: 'Register',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
