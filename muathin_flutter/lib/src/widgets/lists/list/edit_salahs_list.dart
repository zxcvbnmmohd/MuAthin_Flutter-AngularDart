import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/lists/item/edit_salah_item.dart';

class EditSalahsList extends StatefulWidget {
  @override
  _EditSalahsListState createState() => _EditSalahsListState();
}

class _EditSalahsListState extends State<EditSalahsList> {
  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);

    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 0.0, bottom: 20.0),
      itemBuilder: (context, index) {
        return EditSalahItem(
          index: index
        );
      },
      itemCount: userInheritance.user.mosque.salahs.length,
    );
  }
}
