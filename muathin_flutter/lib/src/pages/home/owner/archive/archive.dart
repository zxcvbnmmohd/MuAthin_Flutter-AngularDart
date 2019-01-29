import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';
import 'package:muathin/src/pages/home/owner/archive/post.dart';
import 'package:muathin/src/widgets/lists/list/archive_list.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Archive extends StatefulWidget {
  _ArchiveState createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    List<Widget> w = [ArchiveList()];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Archive',
      leading: Container(),
      actions: <Widget>[
        IconButton(
          icon: ImageIcon(
            AssetImage(Config.pathAdd),
            color: Config.sColor,
          ),
          onPressed: () {
            Functions.navigateTo(context: context, w: Post(), fullscreenDialog: true);
          },
        )
      ],
      heroTag: 'Archive',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
