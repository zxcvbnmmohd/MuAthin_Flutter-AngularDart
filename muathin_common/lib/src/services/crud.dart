import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
  create({DocumentReference ref, Map map, Function onSuccess, Function onFailure(String e)}) {
    ref.setData(map).whenComplete(() {
      onSuccess();
    }).catchError((e) {
      onFailure(e.toString());
    });
  }

  read({DocumentReference ref, Function onSuccess(DocumentSnapshot d), Function onFailure(String e)}) {
    ref.get().then((snapshot) {
      onSuccess(snapshot);
    }).catchError((e) {
      onFailure(e.toString());
    });
  }

  readRT({Stream query, Function onAdded(DocumentSnapshot d), Function onModified(DocumentSnapshot d), Function onRemoved(DocumentSnapshot d), Function onEmpty, Function onFailure(String e)}) {
    query.listen((data) {
      if (data.documents.length != 0) {
        data.documentChanges.forEach((change) {
          if (change.type == DocumentChangeType.added) {
            onAdded(change.document);
          }
          if (change.type == DocumentChangeType.modified) {
            onModified(change.document);
          }
          if (change.type == DocumentChangeType.removed) {
            onRemoved(change.document);
          }
        });
      } else {
        onEmpty();
      }
    }, onError: (e) {
      onFailure(e.toString());
      return;
    });
  }

  update({DocumentReference ref, Map map, Function onSuccess, Function onFailure(String e)}) {
    ref.updateData(map).whenComplete(() {
      onSuccess();
    }).catchError((e) {
      onFailure(e.toString());
      return;
    });
  }
  
  updateArray({DocumentReference ref, String key, Map value, Map m, Function onSuccess, Function onFailure(String e)}) {
    ref.updateData({ key: FieldValue.arrayRemove([value]) }).whenComplete(() {
      ref.updateData({ key: FieldValue.arrayUnion([m]) }).whenComplete(() {
        onSuccess();
      }).catchError((e) {
        onFailure(e.toString());
        return;
      });
    }).catchError((e) {
      onFailure(e.toString());
      return;
    });
  }

  delete({DocumentReference ref, Function onSuccess, Function onFailure(String e)}) {
    ref.delete().whenComplete(() {
      onSuccess();
    }).catchError((e) {
      onFailure(e.toString());
    });
  }
}