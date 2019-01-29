import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


class InheritedCamera extends InheritedWidget {
  final List<CameraDescription> cameras;

  InheritedCamera({Key key, Widget child, this.cameras}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static InheritedCamera of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(InheritedCamera) as InheritedCamera);
  }
}
