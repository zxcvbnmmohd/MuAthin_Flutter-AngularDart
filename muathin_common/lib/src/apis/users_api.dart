import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muathin_common/src/configs/config.dart';
import 'package:muathin_common/src/models/user_model.dart';
import 'package:muathin_common/src/services/services.dart';

class Users {
  final CollectionReference _usersCollection =
      Firestore.instance.collection(Config.users);

  CollectionReference get usersCollection {
    this._usersCollection.firestore.settings(timestampsInSnapshotsEnabled: true);
    return this._usersCollection;
  }

  Future<DocumentSnapshot> currentUserDocument() async {
    String userID = await Services().auth.currentUserID();
    return this.usersCollection.document(userID).get();
  }

  Future<UserModel> currentUser() async {
    DocumentSnapshot ds = await this.currentUserDocument();
    UserModel u = await UserModel().transform(key: ds.documentID, map: ds.data);
    return u;
  }

  Future<DocumentSnapshot> usersRef({String userID}) async {
    return this.usersCollection.document(userID).get();
  }

  Future<UserModel> user(String userID) async {
    DocumentSnapshot ds = await this.usersRef(userID: userID);
    UserModel u = await UserModel().transform(key: ds.documentID, map: ds.data);
    return u;
  }
}
