import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class InheritedUser extends StatefulWidget {
  final Widget child;
  final bool isLoggedIn;
  final UserModel user;
  final MosqueModel mosque;

  InheritedUser({@required this.isLoggedIn, @required this.child, this.user, this.mosque});

  static _InheritedUserState of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(_UserState) as _UserState).data;

  @override
  _InheritedUserState createState() => _InheritedUserState();
}

class _InheritedUserState extends State<InheritedUser> {
  bool _isLoggedIn;
  UserModel _user;
  MosqueModel _mosque;

  @override
  void initState() {
    super.initState();

    widget.isLoggedIn
        ? setState(() {
            this._isLoggedIn = widget.isLoggedIn;
            this._user = widget.user;
            this._mosque = this._user.mosque;
          })
        : setState(() {
            setState(() {
              this._isLoggedIn = widget.isLoggedIn;
              this._mosque = widget.mosque;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return _UserState(data: this, child: widget.child);
  }

  // MARK - Functions

  bool get isLoggedIn => this._isLoggedIn;

  setIsLoggedIn(bool isLoggedIn) {
    setState(() {
      this._isLoggedIn = isLoggedIn;
    });
  }

  UserModel get user => this._user;

  setUser(UserModel user) {
    setState(() {
      this._user = user;
      this._mosque = user.mosque;
    });
  }

  MosqueModel get mosque => this._mosque;

  setMosque(MosqueModel mosque) {
    setState(() {
      this._mosque = mosque;
    });
  }
}

class _UserState extends InheritedWidget {
  final _InheritedUserState data;

  _UserState({Key key, @required this.data, @required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
