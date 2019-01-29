import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String postID, headline, details, url;
  int likes;
  List<String> images = [];
  DocumentReference mosque;
  double distance;
  Timestamp createdAt, updatedAt;

  PostModel transform({String key, Map map}) {
    PostModel post = new PostModel();
    List<dynamic> images = map['images'];

    post.postID = key;
    post.headline = map['headline'];
    post.details = map['details'];
    post.url = map['url'];
    post.likes = map['likes'];

    images.forEach((image) {
      post.images.add(image);
    });

    post.mosque = map['mosque'];
    post.createdAt = map['createdAt'];
    post.updatedAt = map['updatedAt'];

    return post;
  }
}