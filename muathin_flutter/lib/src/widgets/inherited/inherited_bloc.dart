import 'package:flutter/material.dart';

abstract class BLoC {
  void dispose();
}

class InheritedBLoC<B extends BLoC> extends StatefulWidget {
  final Widget child;
  final B bloc;

  InheritedBLoC({Key key, this.child, this.bloc}) : super(key: key);

  @override
  _InheritedBLoCState createState() => _InheritedBLoCState();

  static Type _typeOf<B>() => B;

  static B of<B extends BLoC>(BuildContext context) {
    final type = _typeOf<InheritedBLoC<B>>();
    InheritedBLoC<B> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }
}

class _InheritedBLoCState extends State<InheritedBLoC<BLoC>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}