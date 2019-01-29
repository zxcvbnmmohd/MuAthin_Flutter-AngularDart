import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/widgets/lists/item/feed_item.dart';

class FeedList extends StatefulWidget {
  final String mosqueID;

  FeedList({this.mosqueID});

  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  List<PostModel> _posts = [];
  int _limitTo = 10;

  @override
  void initState() {
    super.initState();
    this._initPosts(mosqueID: widget.mosqueID, posts: this._posts, limitTo: this._limitTo);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 25.0, bottom: 20.0),
      itemBuilder: (context, index) {
        return FeedItem(post: this._posts[index]);
      },
      itemCount: this._posts.length,
    );
  }

  // MARK - Functions

  _initPosts({List<PostModel> posts, String mosqueID, int limitTo}) {
    posts.clear();

    APIs().posts.observeMosquePosts(
        mosqueID: mosqueID,
        limitTo: limitTo,
        onAdded: (p) {
          print('Added');
          if (!mounted) return;
          setState(() {
            posts.add(p);
            posts.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
          });
        },
        onModified: (p) {
          int i = posts.indexWhere((post) => post.postID == p.postID);

          if (!mounted) return;
          setState(() {
            posts[i] = p;
            posts.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
          });
        },
        onRemoved: (p) {
          int i = posts.indexWhere((post) => post.postID == p.postID);

          if (!mounted) return;
          setState(() {
            posts.removeAt(i);
            posts.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
          });
        },
        onEmpty: () {
          print('NO POSTS');
        },
        onFailure: (e) {
          print(e);
        });

    return posts;
  }
}
