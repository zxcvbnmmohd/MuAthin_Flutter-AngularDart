import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/functions.dart';

class FeedItem extends StatefulWidget {
  final PostModel post;

  FeedItem({this.post});

  @override
  _FeedItemState createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            Functions.readDateTime(date: widget.post.updatedAt.toDate()),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            widget.post.headline,
            style: TextStyle(
              color: Config.sColor,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        widget.post.images.isEmpty
            ? Container()
            : Container(
                height: 200.0,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      width: deviceSize.width - 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(widget.post.images[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    );
                  },
                  itemCount: widget.post.images.length,
                ),
              ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            widget.post.details,
            style: TextStyle(color: Config.sColor, fontSize: 15.0, fontWeight: FontWeight.w500),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset(Config.pathLike, scale: 1.2),
                    onTap: () {},
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    widget.post.likes.toString(),
                    style: TextStyle(color: Config.pColor, fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset(Config.pathBookmark, scale: 1.2),
                    onTap: () {},
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    child: Image.asset(Config.pathChat, scale: 1.2),
                    onTap: () {},
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    child: Image.asset(Config.pathSettings, scale: 1.2),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
