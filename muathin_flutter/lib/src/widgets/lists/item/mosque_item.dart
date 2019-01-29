import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';

class MosqueItem extends StatelessWidget {
  final MosqueModel mosque;
  final Function onTap;

  MosqueItem({this.mosque, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0.0, 0.0),
                blurRadius: 10.0,
              ),
            ]),
        height: 75.0,
        margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    this.mosque.name,
                    style: TextStyle(
                      color: Config.sColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    this.mosque.address.short,
                    style: TextStyle(
                      color: Config.sColor,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${this.mosque.address.distance.ceil()} km',
              style: TextStyle(
                color: Config.sColor,
                fontWeight: FontWeight.w300,
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: Config.sColor,
            )
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}
