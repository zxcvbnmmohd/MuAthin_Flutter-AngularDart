import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class ArchiveItem extends StatelessWidget {
  final PostModel post;

  ArchiveItem({this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125.0,
      decoration: BoxDecoration(
        color: Colors.white,

      ),
    );
  }
}
