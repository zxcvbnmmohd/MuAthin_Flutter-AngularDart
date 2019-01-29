import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/lists/list/feed_list.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);
    List<Widget> w = [FeedList(mosqueID: userInheritance.mosque.mosqueID)];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Feed',
      leading: Container(),
      actions: <Widget>[
        IconButton(
          color: Config.sColor,
          icon: ImageIcon(AssetImage(Config.pathSearch)),
          onPressed: () {},
        ),
      ],
      heroTag: 'Feed',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
