import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muathin_common/src/apis/apis.dart';
import 'package:muathin_common/src/models/mosque_model.dart';

class UserModel {
  String userID, name, email, phone, role;
  MosqueModel mosque;
  var createdAt;

  Future<UserModel> transform({String key, Map map}) async {
    UserModel user = new UserModel();
    DocumentReference mosque = map['homeMosque'];

    user.userID = key;
    user.name = map['name'];
    user.email = map['email'];
    user.phone = map['phone'];
    user.role = map['role'];
    user.mosque = await APIs().mosques.mosque(mosqueID: mosque.documentID);
    user.createdAt = map['createdAt'];

    return user;
  }
}
