import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_helpers/firestore_helpers.dart';
import 'package:muathin_common/src/configs/config.dart';
import 'package:muathin_common/src/models/mosque_model.dart';
import 'package:muathin_common/src/services/services.dart';

class Mosques {
  final CollectionReference _mosquesCollection = Firestore.instance.collection(Config.mosques);

  CollectionReference get mosquesCollection {
    this._mosquesCollection.firestore.settings(timestampsInSnapshotsEnabled: true);
    return this._mosquesCollection;
  }

  Future<MosqueModel> mosque({String mosqueID}) async {
    DocumentSnapshot ds = await this.mosquesCollection.document(mosqueID).get();
    return MosqueModel().transform(key: ds.documentID, map: ds.data);
  }

  Stream<List<MosqueModel>> observeGeoMosques(
      {double lat, double lon, double radius, int limitTo, Function onEmpty, Function onFailure(String e)}) {
    return getDataInArea(
        area: Area(GeoPoint(lat, lon), radius),
        source: this.mosquesCollection.limit(limitTo),
        mapper: (doc) {
          return MosqueModel().transform(key: doc.documentID, map: doc.data);
        },
        locationFieldNameInDB: 'address.geopoint',
        locationAccessor: (mosque) => mosque.address.geopoint,
        distanceMapper: (mosque, distance) {
          mosque.address.distance = distance;
          return mosque;
        },
        distanceAccessor: (mosque) => mosque.address.distance,
        sortDecending: true);
  }

  observeMosques(
      {int limitTo,
      Function onAdded(MosqueModel m),
      Function onModified(MosqueModel m),
      Function onRemoved(MosqueModel m),
      Function onEmpty,
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this.mosquesCollection.limit(limitTo).snapshots(),
        onAdded: (ds) {
          onAdded(MosqueModel().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(MosqueModel().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(MosqueModel().transform(key: ds.documentID, map: ds.data));
        },
        onEmpty: () {
          onEmpty();
        },
        onFailure: (e) {
          onFailure(e);
        });
  }
}
