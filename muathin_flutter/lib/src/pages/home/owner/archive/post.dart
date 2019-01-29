import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muathin_common/muathin_common.dart';
import 'package:muathin/src/widgets/inherited/inherited_user.dart';
import 'package:muathin/src/widgets/misc/add_photos.dart';
import 'package:muathin/src/widgets/misc/button.dart';
import 'package:muathin/src/widgets/misc/category.dart';
import 'package:muathin/src/widgets/misc/text_box.dart';
import 'package:muathin/src/widgets/platform_aware/pa_scaffold.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController _headlineTEC = new TextEditingController();
  TextEditingController _detailsTEC = new TextEditingController();
  TextEditingController _urlTEC = new TextEditingController();
  FocusNode _headlineFN = new FocusNode();
  FocusNode _detailsFN = new FocusNode();
  FocusNode _urlFN = new FocusNode();
  List<File> _images = [];

  @override
  Widget build(BuildContext context) {
    final userInheritance = InheritedUser.of(context);

    List<Widget> w = [
      Category(text: 'Photo'),
      AddPhotos(images: this._images),
      Category(text: 'Headline'),
      TextBox(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        controller: this._headlineTEC,
        focusNode: this._headlineFN,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        keyboardAppearance: Brightness.light,
        maxLines: 3,
        onSubmitted: (s) {
          FocusScope.of(context).requestFocus(this._detailsFN);
        },
      ),
      Category(text: 'Details'),
      TextBox(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        controller: this._detailsTEC,
        focusNode: this._detailsFN,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        keyboardAppearance: Brightness.light,
        maxLines: 8,
        onSubmitted: (s) {
          FocusScope.of(context).requestFocus(this._detailsFN);
        },
      ),
      Category(text: 'URL (Optional)'),
      TextBox(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        controller: this._urlTEC,
        focusNode: this._urlFN,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        keyboardAppearance: Brightness.light,
        maxLines: 1,
        onSubmitted: (s) {
          FocusScope.of(context).requestFocus(this._detailsFN);
        },
      ),
      Container(
        margin: EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
        child: Button(
          outline: false,
          text: 'Publish',
          color: Config.sColor,
          height: 60.0,
          onTap: () {
            if (this._headlineTEC.text.isEmpty) {
              FocusScope.of(context).requestFocus(this._headlineFN);
            } else if (this._detailsTEC.text.isEmpty) {
              FocusScope.of(context).requestFocus(this._detailsFN);
            } else {
              String postID = APIs().posts.postsCollection.document().documentID;
              Map<String, dynamic> m = {
                'mosque': APIs().mosques.mosquesCollection.document(userInheritance.mosque.mosqueID),
                'headline': this._headlineTEC.text,
                'details': this._detailsTEC.text,
                'url': this._urlTEC.text,
                'likes': 0,
                'createdAt': DateTime.now(),
                'updatedAt': DateTime.now()
              };

              if (this._images.isEmpty) {
                this._post(
                    postID: postID,
                    m: m,
                    onSuccess: () {
                      this._refrenceToMosqueCollection(
                          mosqueID: userInheritance.mosque.mosqueID,
                          postID: postID,
                          onSuccess: () {
                            Navigator.pop(context);
                          },
                          onFailure: (e) {
                            print(e);
                          });
                    },
                    onFailure: (e) {
                      print(e);
                    });
              } else {
                this._upload(
                    images: this._images,
                    postID: postID,
                    m: m,
                    onSuccess: () {
                      this._refrenceToMosqueCollection(
                          mosqueID: userInheritance.mosque.mosqueID,
                          postID: postID,
                          onSuccess: () {
                            Navigator.pop(context);
                          },
                          onFailure: (e) {
                            print(e);
                          });
                    },
                    onFailure: (e) {
                      print(e);
                    });
              }
            }
          },
        ),
      )
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Edit Post',
      leading: IconButton(
        icon: ImageIcon(
          AssetImage(Config.pathClose),
          color: Config.sColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[Container()],
      heroTag: 'Post',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }

  // MARK - Functions

  _upload({List<File> images, String postID, Map m, Function onSuccess, Function onFailure(String e)}) {
    List<String> imageURLs = [];
    int uploadCount = 0;

    images.forEach((image) {
      Services().storage.upload(
          path: '/posts/$postID/${uploadCount++}.png',
          file: image,
          onSuccess: (url) {
            imageURLs.add(url);
            if (uploadCount == images.length) {
              m['images'] = imageURLs;
              this._post(
                  postID: postID,
                  m: m,
                  onSuccess: () {
                    onSuccess();
                  },
                  onFailure: (e) {
                    print(e);
                  });
            }
          },
          onFailure: (e) {
            onFailure(e);
          });
    });
  }

  _post({String postID, Map<String, dynamic> m, Function onSuccess, Function onFailure(String e)}) {
    Services().crud.create(
        ref: APIs().posts.postsCollection.document(postID),
        map: m,
        onSuccess: () {
          onSuccess();
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  _refrenceToMosqueCollection({String mosqueID, String postID, Function onSuccess, Function onFailure(String e)}) {
    Services().crud.update(
        ref: APIs().mosques.mosquesCollection.document(mosqueID).collection('posts').document(postID),
        map: <String, dynamic>{},
        onSuccess: () {
          onSuccess();
        },
        onFailure: (e) {
          onFailure(e);
        });
  }
}
