import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';
import 'package:muathin/src/pages/home/home.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/lists/item/mosque_item.dart';

class MosquesList extends StatefulWidget {
  final List<MosqueModel> mosques;

  MosquesList({this.mosques});

  @override
  _MosquesListState createState() => _MosquesListState();
}

class _MosquesListState extends State<MosquesList> {
  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);

    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10.0),
      itemBuilder: (context, index) {
        MosqueModel m = widget.mosques[index];
        return MosqueItem(
          mosque: m,
          onTap: () {
            userInheritance.setIsLoggedIn(false);
            userInheritance.setMosque(m);
            Functions.navigateTo(context: context, w: Home(), fullscreenDialog: true);
          },
        );
      },
      itemCount: widget.mosques.length,
    );
  }
}
