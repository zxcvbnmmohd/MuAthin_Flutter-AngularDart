import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import 'package:muathin_common/src/apis/apis.dart';
import 'package:muathin_common/src/configs/config.dart';
import 'package:muathin_common/src/models/post_model.dart';
import 'package:muathin_common/src/services/services.dart';

class Posts {
  final CollectionReference _postsCollection = Firestore.instance.collection(Config.posts);

  CollectionReference get postsCollection {
    this._postsCollection.firestore.settings(timestampsInSnapshotsEnabled: true);
    return this._postsCollection;
  }

  Future<PostModel> post({String postID}) async {
    DocumentSnapshot ds = await this.postsCollection.document(postID).get();
    return PostModel().transform(key: ds.documentID, map: ds.data);
  }

  observeMosquePosts(
      {String mosqueID,
      int limitTo,
      Function onAdded(PostModel m),
      Function onModified(PostModel m),
      Function onRemoved(PostModel m),
      Function onEmpty,
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this
            .postsCollection
            .where('mosque', isEqualTo: APIs().mosques.mosquesCollection.document(mosqueID))
            .limit(limitTo)
            .snapshots(),
        onAdded: (ds) {
          onAdded(PostModel().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(PostModel().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(PostModel().transform(key: ds.documentID, map: ds.data));
        },
        onEmpty: () {
          onEmpty();
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  Stream<List<PostModel>> observeGeoPosts(
      {double lat, double lon, double radius, int limitTo, Function onEmpty, Function onFailure(String e)}) {
    return getDataInArea(
        area: Area(GeoPoint(lat, lon), radius),
        source: this.postsCollection.limit(limitTo),
        mapper: (doc) {
          return PostModel().transform(key: doc.documentID, map: doc.data);
        },
        locationFieldNameInDB: 'geopoint',
//        locationAccessor: (post) => post.geopoint,
        distanceMapper: (post, distance) {
          post.distance = distance;
          return post;
        },
        distanceAccessor: (post) => post.distance,
        sortDecending: true);
  }
}
