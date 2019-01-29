import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/widgets/lists/list/edit_salahs_list.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class EditSalahs extends StatefulWidget {
  _EditSalahsState createState() => _EditSalahsState();
}

class _EditSalahsState extends State<EditSalahs> {
  @override
  Widget build(BuildContext context) {
    List<Widget> w = [
      EditSalahsList(),
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Edit Profile',
      leading: Container(),
      actions: <Widget>[Container()],
      heroTag: 'EditSalahs',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
